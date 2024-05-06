require "rails_helper"

RSpec.describe "Backoffice::Doctors", type: :request do
  describe "GET /index" do
    it "returns http success when user is manager" do
      sign_in FactoryBot.create(:manager_with_role)
      get backoffice_doctors_path
      expect(response).to have_http_status(:ok)
    end

    it "returns http forbidden when user is not manager" do
      sign_in FactoryBot.create(:doctor_with_role)
      get backoffice_doctors_path
      expect(response).to have_http_status(:forbidden)
    end

    it "redirect http when not loggedin" do
      get backoffice_doctors_path
      expect(response).to redirect_to(new_user_session_url)
    end
  end

  describe "POST /doctor" do
    it "returns http success when user is manager" do
      FactoryBot.create(:doctor_role)
      specialty = FactoryBot.create(:specialty)

      sign_in FactoryBot.create(:manager_with_role)

      user_attributes = FactoryBot.attributes_for(:doctor, specialty_id: specialty.id)

      post backoffice_doctors_path, params: { doctor: user_attributes }

      expect(response).to redirect_to(backoffice_doctors_path)
    end

    it "returns http forbidden when user is not manager" do
      sign_in FactoryBot.create(:doctor_with_role)

      user_attributes = FactoryBot.attributes_for(:doctor)

      post backoffice_doctors_path, params: { doctor: user_attributes }

      expect(response).to have_http_status(:forbidden)
    end
  end

  describe "PUT /doctor" do
    it "returns http success when user is self" do
      doctor = FactoryBot.create(:doctor_with_role)

      sign_in doctor

      put backoffice_doctor_path(doctor), params: { action: "update",
                                                    doctor: { name: "John Cena" } }
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(root_path)
    end

    it "returns http success when user is manager" do
      manager = FactoryBot.create(:manager_with_role)
      doctor = FactoryBot.create(:doctor_with_role)
      sign_in manager

      put backoffice_doctor_path(doctor), params: { action: "update",
                                                    doctor: { name: "John Cena" } }
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(backoffice_doctors_path)
    end

    it "returns http forbidden when user is not manager or self" do
      sign_in FactoryBot.create(:doctor_with_role)
      doctor = FactoryBot.create(:doctor_with_role, email: "some.user@acme.com")

      put backoffice_doctor_path(doctor), params: { doctor: { name: "John Cena" } }

      expect(response).to have_http_status(:forbidden)
    end

    it "returns http success when password and password confirmation are correctly" do
      manager = FactoryBot.create(:manager_with_role)
      doctor = FactoryBot.create(:doctor_with_role)
      sign_in manager

      put backoffice_doctor_path(doctor), params: { action: "update",
                                                   doctor: { name: "John Cena",
                                                             password: "123456",
                                                             password_confirmation: "123456" } }
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(backoffice_doctors_path)
    end

    it "returns http unprocessable entity when password confirmation is missing" do
      manager = FactoryBot.create(:manager_with_role)
      doctor = FactoryBot.create(:doctor_with_role)
      sign_in manager

      put backoffice_doctor_path(doctor), params: { action: "update",
                                                    doctor: { name: "John Cena", password: "123456" } }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "returns http unprocessable entity when password and password confirmation doesnt match" do
      manager = FactoryBot.create(:manager_with_role)
      doctor = FactoryBot.create(:doctor_with_role)
      sign_in manager

      put backoffice_doctor_path(doctor), params: { action: "update",
                                                   doctor: { name: "John Cena",
                                                             password: "123456",
                                                             password_confirmation: "654321" } }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "DELETE /doctor" do
    it "returns http success" do
      manager = FactoryBot.create(:manager_with_role)
      sign_in manager
      doctor = FactoryBot.create(:doctor_with_role, email: "some.user@acme.com")

      get backoffice_doctors_path

      delete backoffice_doctor_path(doctor)

      expect(response).to have_http_status(:redirect)
    end

    it "returns http forbidden" do
      sign_in FactoryBot.create(:doctor_with_role)
      role = FactoryBot.create(:role)
      user = FactoryBot.create(:doctor, email: "some.user@acme.com", roles: [role])

      delete backoffice_doctor_path(user)

      expect(response).to have_http_status(:forbidden)
    end
  end
end
