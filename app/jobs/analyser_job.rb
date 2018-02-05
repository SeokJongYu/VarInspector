class AnalyserJob < ApplicationJob
    queue_as :default
  
    def perform(analysis_id) 
        JobWorker.new.exec(analysis_id)
    end
  
end
