class ResultController < ApplicationController
  def show
    @results = Result.where("analysis_id =?", params[:analysis_id])
    @analysis = Analysis.find(params[:analysis_id])
    
  end

  def plot
  end
end
