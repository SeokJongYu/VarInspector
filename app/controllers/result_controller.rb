class ResultController < ApplicationController
  def show
    @results = Result.where("analysis_id =?", params[:analysis_id])
    @analysis = Analysis.find(params[:analysis_id])
    
    respond_to do |format| 
      format.html 
      format.xls
    end 
  end

  def plot
  end

  def report
    @results = Result.where("analysis_id =?", params[:analysis_id])
    @analysis = Analysis.find(params[:analysis_id])

    pdf = Report.new(@analysis, @results)
    send_data pdf.render, filename: "analysis_report.pdf", type: "application/pdf" , disposition: "inline"

  end
end
