class CaseResultsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def index
    case_results = CaseResult.find_case_name(params[:case_name])
                              .find_case_type(params[:case_type])
    if params[:format] == "csv"
      respond_to do |format|
        format.html
        format.csv { send_data case_results.to_csv, filename: "result-#{Time.current.strftime("%Y%m%d%H%M%S")}.csv" }
      end
    else
      @case_results = case_results.page(params[:page]).per(8)
    end
  end

  def create
    @case_result = CaseResult.new(case_result_params)
    @case_result.case_name = @case_result.case.name
    @case_result.case_tag = @case_result.case.tag
    if @case_result.save
			render json: { status: 'ok', message: '保存成功' }
		else
			render json: { status: 'error', message: '保存失败' }
		end
  end

  def export
    @case_result = CaseResult.find(params[:id])
    respond_to do |format|
      format.html
      format.csv { send_data @case_result.to_csv, filename: "#{@case_result.case_name}-#{@case_result.case_type_view}.csv" }
    end
  end

  private

    def case_result_params
      params.require(:case_result).permit(:case_id, :case_type, result_array: [], path_array: [])
    end
end