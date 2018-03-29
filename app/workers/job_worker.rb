class JobWorker

    def exec(analysis_id)
      puts analysis_id
      analysis = Analysis.find(analysis_id)
      # - make input file
      #create_data(analysis)
      #create_script(analysis)

      # - create slurm controller and lanch
      #lanch_slurm_job(analysis)


      # -monitoring analysis job and do post processing
      #poll_job(analysis)
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
      @job_name = project.title + "_" + analysis.id.to_s
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
      @script_content ="#!/bin/sh\n\n"

      @script_content  << "#SBATCH -D /blues/ngs/service/varinspector/snakemake\n"
      @script_content  << "#SBATCH -o /blues/ngs/service/varinspector/snakemake/logs/%j.out\n"
      @script_content  << "#SBATCH -p debug\n"
      @script_content  << "#SBATCH -c 1\n\n"

      @script_content  << "PREFIX='#{@analysis_name_prefix}'\n"
      @script_content  << "DATA_PATH='#{@dir_str}'\n"
      @script_content  << "JOB_NUM=2\n"
      @script_content  << "\n"

      @script_content  << "/cluster/ngs/snakemake/bin/snakemake -d $DATA_PATH --configfile /blues/ngs/service/varinspector/snakemake/config.json -C \"target=$PREFIX\" -j $JOB_NUM --ri -k --cluster \"sbatch -p debug -c{threads} -D $DATA_PATH -o $DATA_PATH/%x.out\""
      @script_content  << "\n"
    end

    def lanch_slurm_job(analysis)

      config = {"adapter" => "slurm", "cluster" => "biocluster", "conf" => "/etc/slurm/slurm.conf", "bin" => "/usr/bin"}
      @slurm_adptor = OodCore::Job::Factory.build(config)
      
      @script = OodCore::Job::Script.new(:content => @script_content, :job_name => @job_name)
	    puts @script.to_h
      slurm_id = @slurm_adptor.submit (@script)

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
        
        if @stat.queued?  
          stat_server = "Queue"
        elsif @stat.queued_held?
          stat_server = "Queued held"
	elsif @stat.suspended?
          stat_server = "Suspended"
	elsif @stat.running?
          stat_server = "Running"
        elsif @stat.completed?
          stat_server = "Done"
        end
  	puts stat_server

        if stat_server != status
          analysis.status = stat_server
          analysis.save
          sleep 10
        end
      end
    end
  
    def post_processing(analysis)
      @analysis_name_prefix = "PMG353"
      # @mutect_high_file = analysis.result_dir + "/"+ @analysis_name_prefix + ".mutect.HIGH.txt"
      # @mutect_moderate_file = analysis.result_dir + "/"+ @analysis_name_prefix + ".mutect.MODERATE.txt"
      # @strelka_high_file = analysis.result_dir + "/"+ @analysis_name_prefix + ".strelka.HIGH.txt"
      # @strelka_moderate_file = analysis.result_dir + "/"+ @analysis_name_prefix + ".strelka.MODERATE.txt"

      @mutect_file = "/Users/seokjongyu/Dev/KAIST/data/"+ @analysis_name_prefix + ".mutect.txt"
      @strelka_file = "/Users/seokjongyu/Dev/KAIST/data/"+ @analysis_name_prefix + ".strelka.txt"
      @gatk_file = "/Users/seokjongyu/Dev/KAIST/data/"+ @analysis_name_prefix + ".gatk_hc.txt"
      @lofreq_file = "/Users/seokjongyu/Dev/KAIST/data/"+ @analysis_name_prefix + ".Lofreq.txt"

      puts @mutect_file
      processing_detail(@mutect_file, "mutect", analysis)
      puts @gatk_file
      processing_detail(@gatk_file, "gatk_hc", analysis)
      puts @strelka_file
      processing_detail(@strelka_file, "strelka", analysis)
      puts @lofreq_file
      processing_detail(@lofreq_file, "Lofreq", analysis)

      analysis.status = "Finish"
      analysis.save

    end

    def processing_detail(data, tool_str, analysis)
      # create Result
      csv_text = File.read(data)
      csv = CSV.parse(csv_text, :col_sep =>"\t", :headers => true)
      csv.each do |row|
        puts row.to_hash
        result = Result.create(row.to_hash)
        result.tool = tool_str
        result.analysis = analysis
        result.save
      end
    end

end
