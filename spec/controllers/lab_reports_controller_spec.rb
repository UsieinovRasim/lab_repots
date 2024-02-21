# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LabReportsController do
  let(:valid_attributes) do
    { title: 'Report Title', description: 'Report Description', grade: 'A' }
  end

  let(:invalid_attributes) do
    { title: '', description: '', user_id: nil, grade: 'Invalid Grade' }
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      user = User.create!(first_name: 'Jim', last_name: 'Carrey', email: 'jim@gmail.com')
      lab_report = LabReport.create!(valid_attributes.merge(user_id: user.id))
      get :show, params: { id: lab_report.id }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new LabReport' do
        user = User.create!(first_name: 'Jim', last_name: 'Carrey', email: 'jim@gmail.com')
        valid_attributes[:user_id] = user.id
        expect do
          post :create, params: { lab_report: valid_attributes }
        end.to change(LabReport, :count).by(1)
      end

      it 'redirects to the lab_reports index' do
        user = User.create!(first_name: 'John', last_name: 'Doe', email: 'john@example.com')
        valid_attributes[:user_id] = user.id
        post :create, params: { lab_report: valid_attributes }
        expect(response).to redirect_to(lab_reports_path)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new LabReport' do
        expect do
          post :create, params: { lab_report: invalid_attributes }
        end.not_to change(LabReport, :count)
      end

      it 'renders the new template' do
        post :create, params: { lab_report: invalid_attributes }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      user = User.create!(first_name: 'Jim', last_name: 'Carrey', email: 'jim@gmail.com')
      lab_report = LabReport.create!(valid_attributes.merge(user_id: user.id))

      get :edit, params: { id: lab_report.id }
      expect(response).to be_successful
    end
  end

  describe 'PUT #update' do
    context 'with valid parameters' do
      let(:user) { User.create!(first_name: 'Jim', last_name: 'Carrey', email: 'jim@gmail.com') }
      let(:lab_report) { LabReport.create!(valid_attributes.merge(user_id: user.id)) }
      let(:new_attributes) do
        { title: 'New Report Title', description: 'New Report Description', grade: 'B' }
      end

      it 'updates the requested lab_report' do
        put :update, params: { id: lab_report.id, lab_report: new_attributes }
        lab_report.reload
        expect(lab_report.title).to eq(new_attributes[:title])
        expect(lab_report.description).to eq(new_attributes[:description])
        expect(lab_report.grade).to eq(new_attributes[:grade])
      end

      it 'redirects to the lab_report' do
        put :update, params: { id: lab_report.id, lab_report: valid_attributes }
        expect(response).to redirect_to(lab_report_path(lab_report))
      end
    end

    context 'with invalid parameters' do
      it 'renders the edit template' do
        user = User.create!(first_name: 'Jim', last_name: 'Carrey', email: 'jim@gmail.com')
        lab_report = LabReport.create!(valid_attributes.merge(user_id: user.id))
        put :update, params: { id: lab_report.id, lab_report: invalid_attributes }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested lab_report' do
      user = User.create!(first_name: 'Jim', last_name: 'Carrey', email: 'jim@gmail.com')
      lab_report = LabReport.create!(valid_attributes.merge(user_id: user.id))
      expect do
        delete :destroy, params: { id: lab_report.id }
      end.to change(LabReport, :count).by(-1)
    end

    it 'redirects to the lab_reports list' do
      user = User.create!(first_name: 'Jim', last_name: 'Carrey', email: 'jim@gmail.com')
      lab_report = LabReport.create!(valid_attributes.merge(user_id: user.id))
      delete :destroy, params: { id: lab_report.id }
      expect(response).to redirect_to(lab_reports_url)
    end
  end
end
