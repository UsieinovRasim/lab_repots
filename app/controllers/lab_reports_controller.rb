# frozen_string_literal: true

class LabReportsController < ApplicationController
  before_action :set_lab_report, only: %i[show edit update destroy]

  def index
    @lab_reports = LabReport.order(id: :asc)
  end

  def show; end

  def new
    @lab_report = LabReport.new
  end

  def create
    @lab_report = LabReport.new(lab_report_params)
    if @lab_report.save
      redirect_to lab_reports_path, notice: 'Отчет о лабораторной работе успешно создан'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @lab_report.update(lab_report_params)
      redirect_to lab_reports_path
    else
      render :edit
    end
  end

  def destroy
    @lab_report.destroy
    redirect_to lab_reports_path
  end

  private

  def set_lab_report
    @lab_report = LabReport.find(params[:id])
  end

  def lab_report_params
    params.require(:lab_report).permit(:title, :description, :user_id, :grade)
  end
end
