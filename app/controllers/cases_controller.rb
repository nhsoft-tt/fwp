class CasesController < ApplicationController

  def index
    @cases = Case.find_name(params[:name])
                 .find_username(params[:username])
                 .find_tag(params[:tag])
                 .page(params[:page])
                 .per(8)
  end

  def new
    @case = Case.new
  end

  def create
    @case = Case.new(case_params)
    @case.file = params[:case][:file].original_filename
    @case.file_body = File.read(params[:case][:file].tempfile)
    if @case.save
			flash[:success] = "案例添加成功"
			redirect_to root_url
		else
			flash.now[:error] = "案例添加失败。#{@case.errors.full_messages.to_sentence}"
			render :new
		end
  end

  def show
    @case = Case.find_by(id: params[:id])
  end

  private

    def case_params
      params.require(:case).permit(:username, :name, :tag, :desc)
    end
end