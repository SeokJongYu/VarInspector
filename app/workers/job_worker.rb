class JobWorker
    require 'fileutils'
    require 'csv'
  
    def exec(analysis_id)
      
      analysis = Analysis.find(analysis_id)
      # make input file
      create_data(analysis)

      # create slurm controller and lanch
      # lanch_slurm_job(analysis)
      # monitoring analysis job and do post processing
      # poll_job(analysis)
      # post_processing(analysis)
  
    end
  
    def create_data(analysis)

      project = analysis.project

      blood_file1 = analysis.seq_blood1_data
      blood_file2 = analysis.seq_blood2_data
      brain_file1 = analysis.seq_brain1_data
      brain_file2 = analysis.seq_brain2_data

      hash1 = eval(blood_file1)
      blood_file1_loc = "public/uploads/store/" + hash1[:id]
      user_file1 = hash1[:metadata][:filename]
      user_file1.gsub! '-', ''

      hash2 = eval(blood_file2)
      blood_file2_loc = "public/uploads/store/" + hash2[:id]
      user_file2 = hash2[:metadata][:filename]
      user_file2.gsub! '-', ''

      hash3 = eval(brain_file1)
      brain_file1_loc = "public/uploads/store/" + hash3[:id]
      user_file3 = hash3[:metadata][:filename]
      user_file3.gsub! '-', ''

      hash4 = eval(brain_file2)
      brain_file2_loc = "public/uploads/store/" + hash4[:id]
      user_file4 = hash4[:metadata][:filename]
      user_file4.gsub! '-', ''

  
      @dir_str = "/tmp/KAIST/" + project.title + "/" + analysis.id.to_s
      @blood_file1_str = @dir_str + '/' + user_file1 + "-BL_1.fastq.gz"
      @blood_file2_str = @dir_str + '/' + user_file2 + "-BL_2.fastq.gz"
      @brain_file1_str = @dir_str + '/' + user_file3 + "-Br_1.fastq.gz"
      @brain_file2_str = @dir_str + '/' + user_file4 + "-Br_2.fastq.gz"

      FileUtils::mkdir_p @dir_str
      #copy the file form /public/uploads/ to working dir
      FileUtils.mv(blood_file1_loc, @blood_file1_str)
      FileUtils.mv(blood_file2_loc, @blood_file2_str)
      FileUtils.mv(brain_file1_loc, @brain_file1_str)
      FileUtils.mv(brain_file2_loc, @brain_file2_str)
    end
  
  
  
    def lanch_slurm_job(analysis)
      # @b = PBS::Batch.new(
      #   host: 'manjaro-codegen',
      #   lib: '/usr/lib',
      #   bin: '/usr/bin'
      #   )
      # @job_id = @b.submit_script(@script_file)
  
      # analysis.job_id = @job_id
      # analysis.status = "submit"
      # analysis.save
    end
  
    def poll_job(analysis)
      # job_id = analysis.job_id
      # status = analysis.status
      # stat_server = "submit"
      # until stat_server == "Done"  do
      #   @stat = @b.get_job(job_id)
      #   puts @stat.to_yaml
      #   puts ">>>>>"
      #   puts job_id
      #   @stat.each_key {|key| puts key }
      #   val = @stat[job_id]
      #   stat_str = val[:job_state]
      #   if stat_str == "Q" 
      #     stat_server = "Queue"
      #   elsif stat_str == "R"
      #     stat_server = "Running"
      #   elsif stat_str == "C"
      #     stat_server = "Done"
      #   end
  
      #   if stat_server != status
      #     analysis.status = stat_server
      #     analysis.save
      #     sleep 10
      #   end
        
      # end
    end
  
    def post_processing(analysis)
      # create Result
      # result = Result.new()
      # result.location = @output_file
      # result.analysis = analysis
      # result.save
  
      # csv_text = File.read(@output_file)
      # csv = CSV.parse(csv_text, :col_sep =>"\t", :headers => true, :converters => lambda { |s| s.tr("-","") })
      # csv.each do |row|
      #   puts row.to_hash
      #   mhc_result = MhciResult.create(row.to_hash)
      #   mhc_result.result = result
      #   mhc_result.save
      
      # end
      
    end

end