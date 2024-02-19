class LabReportsController < ApplicationController
  # before_action :set_user, only: %i[ new create ]
  before_action :set_lab_report, only: %i[ show edit update destroy ]

  def index
    @lab_reports = LabReport.all
  end

  def show
  end

  def new
    @lab_report = LabReport.new
  end

  def create
    #binding.pry
    @lab_report = LabReport.new(lab_report_params)
    if @lab_report.save
      redirect_to lab_reports_path, notice: 'Отчет о лабораторной работе успешно создан'
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_lab_report
    @lab_report = LabReport.find(params[:id])
  end

  def lab_report_params
    params.require(:lab_report).permit(:title, :description, :user_id, :grade)
  end
end
