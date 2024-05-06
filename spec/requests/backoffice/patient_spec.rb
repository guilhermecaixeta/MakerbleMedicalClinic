require "rails_helper"

RSpec.describe "Backoffice::Patients", type: :request do
  describe "GET /index" do
    it "returns http success when user is manager" do
      sign_in FactoryBot.create(:manager_with_role)

      get backoffice_patients_path

      expect(response).to have_http_status(:ok)
    end

    it "returns http forbidden when user is not manager" do
      sign_in FactoryBot.create(:operator_with_role)

      get backoffice_patients_path

      expect(response).to have_http_status(:ok)
    end

    it "redirect http when not loggedin" do
      get backoffice_patients_path
      expect(response).to redirect_to(new_user_session_url)
    end
  end

  describe "POST /patient" do
    it "returns http success when user is manager" do
      sign_in FactoryBot.create(:manager_with_role)

      user_attributes = FactoryBot.attributes_for(:patient)

      post backoffice_patients_path, params: { patient: user_attributes }

      expect(response).to redirect_to(backoffice_patients_path)
    end

    it "returns http success when user is operator" do
      sign_in FactoryBot.create(:manager_with_role)

      user_attributes = FactoryBot.attributes_for(:patient)

      post backoffice_patients_path, params: { patient: user_attributes }

      expect(response).to redirect_to(backoffice_patients_path)
    end

    it "returns http forbidden when user is not manager" do
      sign_in FactoryBot.create(:doctor_with_role)

      user_attributes = FactoryBot.attributes_for(:patient)

      post backoffice_patients_path, params: { patient: user_attributes }

      expect(response).to have_http_status(:forbidden)
    end
  end

  describe "PUT /patient" do
    it "returns http success when user is operator" do
      patient = FactoryBot.create(:patient)
      sign_in FactoryBot.create(:operator_with_role)

      put backoffice_patient_path(patient), params: { patient: { name: "John Cena" } }

      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(backoffice_patients_path)
    end

    it "returns http success when user is manager" do
      patient = FactoryBot.create(:patient)
      sign_in FactoryBot.create(:manager_with_role)

      put backoffice_patient_path(patient), params: { patient: { name: "John Cena" } }

      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(backoffice_patients_path)
    end

    it "returns http forbidden when user is not authorized" do
      patient = FactoryBot.create(:patient)
      sign_in FactoryBot.create(:doctor_with_role)

      put backoffice_patient_path(patient), params: { patient: { name: "John Cena" } }

      expect(response).to have_http_status(:forbidden)
    end
  end

  describe "DELETE /patient" do
    it "returns http success" do
      patient = FactoryBot.create(:patient)
      sign_in FactoryBot.create(:manager_with_role)

      delete backoffice_patient_path(patient)

      expect(response).to have_http_status(:redirect)
    end

    it "returns http forbidden" do
      patient = FactoryBot.create(:patient)

      sign_in FactoryBot.create(:doctor_with_role)

      delete backoffice_patient_path(patient)

      expect(response).to have_http_status(:forbidden)
    end
  end
end
