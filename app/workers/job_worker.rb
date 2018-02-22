class JobWorker
    require 'fileutils'
    require 'csv'
  
    def exec(analysis_id)
      put analysis_id
      analysis = Analysis.find(analysis_id)
      # make input file
      create_data(analysis)

      # create slurm controller and lanch
      lanch_slurm_job(analysis)

      create_script(anlysis)

      # monitoring analysis job and do post processing
      poll_job(analysis)
      post_processing(analysis)
  
    end
  
    def create_data(analysis)

      project = analysis.project

      blood_file1 = analysis.seq_blood1_data
      blood_file2 = analysis.seq_blood2_data
      brain_file1 = analysis.seq_brain1_data
      brain_file2 = analysis.seq_brain2_data

      hash1 = eval(blood_file1)
      blood_file1_loc = "public/uploads/store/" + hash1[:id]

      hash2 = eval(blood_file2)
      blood_file2_loc = "public/uploads/store/" + hash2[:id]

      hash3 = eval(brain_file1)
      brain_file1_loc = "public/uploads/store/" + hash3[:id]

      hash4 = eval(brain_file2)
      brain_file2_loc = "public/uploads/store/" + hash4[:id]

      @analysis_name_prefix = analysis.name
      @analysis_name_prefix.gsub! '-', ''
      @analysis_name_prefix.gsub! ' ', ''
  
      @dir_str = "/blues/ngs/service/varinspector/" + project.title + "/" + analysis.id.to_s
      @blood_file1_str = @dir_str + '/' + @analysis_name_prefix + "-BL_1.fastq.gz"
      @blood_file2_str = @dir_str + '/' + @analysis_name_prefix + "-BL_2.fastq.gz"
      @brain_file1_str = @dir_str + '/' + @analysis_name_prefix + "-Br_1.fastq.gz"
      @brain_file2_str = @dir_str + '/' + @analysis_name_prefix + "-Br_2.fastq.gz"

      FileUtils::mkdir_p @dir_str
      #copy the file form /public/uploads/ to working dir
      FileUtils.mv(blood_file1_loc, @blood_file1_str)
      FileUtils.mv(blood_file2_loc, @blood_file2_str)
      FileUtils.mv(brain_file1_loc, @brain_file1_str)
      FileUtils.mv(brain_file2_loc, @brain_file2_str)
    end
  
  
    def create_script(analysis)
      @script_file = @dir_str + '/run.sh'
      @JOB_NUM = 2
      begin
        script = File.open(@script_file, "w")
        script.write("#!/bin/sh\n")
        script.write("\n")
        script.write("#SBATCH -D /blues/ngs/service/varinspector/snakemake\n")
        script.write("#SBATCH -o /blues/ngs/service/varinspector/snakemake/logs/%j.out\n")
        script.write("#SBATCH -p all\n")
        script.write("#SBATCH -c 1\n")
        script.write("\n")

        script.write("PREFIX='#{@analysis_name_prefix}'\n")
        script.write("DATA_PATH='#{@dir_str}'\n")
        script.write("JOB_NUM=2\n")
        script.write("\n")

        script.write("/cluster/ngs/snakemake/bin/snakemake -d $DATA_PATH --configfile /blues/ngs/service/varinspector/snakemake/config.json -C \"target=$PREFIX\" -j $JOB_NUM --ri -k --cluster \"sbatch -p all -c{threads} -D $DATA_PATH -o $DATA_PATH/%x.out\"")
        script.write("\n")
  
      rescue IOError => e 
      ensure
        script.close unless script.nil?
      end
      

    end

    def lanch_slurm_job(analysis)

      config = {"adapter" => "slurm", "cluster" => "biocluster3", "conf" => "/etc/slurm", "bin" => "/usr/sbin"}
      @slurm_adptor = OodCore::Job::Factory.build_slurm(config)

      #submit_script = "runService.sh " + @dir_str +" "+@analysis_name_prefix
      #puts submit_script
      slurm_id = @slurm_adptor.submit (@script_file)

      analysis.job_id = slurm_id
      analysis.status = "submit"
      analysis.result_dir = @dir_str
      analysis.save

    end
  
    def poll_job(analysis)
      job_id = analysis.job_id
      status = analysis.status
      stat_server = "submit"
      until stat_server == "Done"  do
        @stat = @slurm_adptor.status(job_id)
        puts @stat.to_yaml
        puts job_id
        @stat.each_key {|key| puts key }
        val = @stat[job_id]
        stat_str = val[:job_state]
        if stat_str == "Q" 
          stat_server = "Queue"
        elsif stat_str == "R"
          stat_server = "Running"
        elsif stat_str == "C"
          stat_server = "Done"
        end
  
        if stat_server != status
          analysis.status = stat_server
          analysis.save
          sleep 10
        end
      end
    end
  
    def post_processing(analysis)
      # create Result
      @output_file = analysis.result_dir + "/*.vcf"
      csv_text = File.read(@output_file)
      csv = CSV.parse(csv_text, :col_sep =>"\t", :headers => true, :converters => lambda { |s| s.tr("[*].","_") })
      csv.each do |row|
        puts row.to_hash
        result = Result.create(row.to_hash)
        result.analysis = analysis
        result.save
      end
    end

end