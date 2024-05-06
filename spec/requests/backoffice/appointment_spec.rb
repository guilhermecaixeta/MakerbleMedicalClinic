require "rails_helper"

RSpec.describe "Backoffice::Appointments", type: :request do
  describe "GET /index" do
    it "returns http success when user is manager" do
      sign_in FactoryBot.create(:manager_with_role)
      get backoffice_appointments_path
      expect(response).to have_http_status(:success)
    end

    it "returns http forbidden when user is not authorized" do
      sign_in FactoryBot.create(:doctor)
      get backoffice_appointments_path
      expect(response).to have_http_status(:forbidden)
    end

    it "redirect http when not loggedin" do
      get backoffice_appointments_path
      expect(response).to redirect_to(new_user_session_url)
    end
  end

  describe "POST /appointments" do
    it "returns http success when user is manager" do
      specialty = FactoryBot.create(:specialty)
      patient = FactoryBot.create(:patient)
      doctor = FactoryBot.create(:doctor)

      sign_in FactoryBot.create(:manager_with_role)

      appointment_attributes = FactoryBot.attributes_for(:appointment,
                                                         specialty_id: specialty.id,
                                                         patient_id: patient.id,
                                                         user_id: doctor.id)

      post backoffice_appointments_path, params: { appointment: appointment_attributes }

      expect(response).to redirect_to(backoffice_appointments_path)
    end

    it "returns http success when user is operator" do
      operator = FactoryBot.create(:operator_with_role)
      specialty = FactoryBot.create(:specialty)
      patient = FactoryBot.create(:patient)
      doctor = FactoryBot.create(:doctor)

      sign_in operator

      appointment_attributes = FactoryBot.attributes_for(:appointment,
                                                         specialty_id: specialty.id,
                                                         patient_id: patient.id,
                                                         user_id: doctor.id)

      post backoffice_appointments_path, params: { appointment: appointment_attributes }

      expect(response).to redirect_to(backoffice_appointments_path)
    end

    it "returns http forbidden when user is doctor" do
      specialty = FactoryBot.create(:specialty)
      patient = FactoryBot.create(:patient)
      doctor = FactoryBot.create(:doctor)

      sign_in FactoryBot.create(:doctor_with_role, email: "doctor@test.com")

      appointment_attributes = FactoryBot.attributes_for(:appointment,
                                                         specialty_id: specialty.id,
                                                         patient_id: patient.id,
                                                         user_id: doctor.id)

      post backoffice_appointments_path, params: { appointment: appointment_attributes }

      expect(response).to have_http_status(:forbidden)
    end
  end

  describe "PUT /appointments" do
    it "returns http success when user is manager" do
      manager = FactoryBot.create(:manager_with_role)
      sign_in manager
      appointment = FactoryBot.create(:appointment)

      put backoffice_appointment_path(appointment),
          params: { appointment: { start_date_time: Time.now + 3.hours,
                                  end_date_time: Time.now + 4.hours } }

      expect(response).to redirect_to(backoffice_appointments_path)
    end

    it "returns http success when user is operator" do
      appointment = FactoryBot.create(:appointment)
      sign_in FactoryBot.create(:operator_with_role)

      put backoffice_appointment_path(appointment),
          params: { appointment: { start_date_time: Time.now + 3.hours,
                                  end_date_time: Time.now + 4.hours } }

      expect(response).to redirect_to(backoffice_appointments_path)
    end

    it "returns http forbidden when user is doctor" do
      doctor = FactoryBot.create(:doctor_with_role)
      appointment = FactoryBot.create(:appointment, doctor: doctor)

      sign_in doctor

      put backoffice_appointment_path(appointment),
          params: { appointment: { start_date_time: Time.now + 3.hours,
                                  end_date_time: Time.now + 4.hours } }

      expect(response).to have_http_status(:forbidden)
    end
  end

  describe "DELETE /appointments" do
    it "returns http success when user is manager" do
      appointment = FactoryBot.create(:appointment)
      sign_in FactoryBot.create(:manager_with_role)

      delete backoffice_appointment_path(appointment)

      expect(response).to redirect_to(root_path)
    end

    it "returns http success when user is operator" do
      appointment = FactoryBot.create(:appointment)

      sign_in FactoryBot.create(:operator_with_role)

      delete backoffice_appointment_path(appointment)

      expect(response).to redirect_to(root_path)
    end

    it "returns http forbidden when user is doctor" do
      doctor = FactoryBot.create(:doctor_with_role)

      sign_in doctor

      appointment = FactoryBot.create(:appointment, doctor: doctor)

      delete backoffice_appointment_path(appointment)

      expect(response).to have_http_status(:forbidden)
    end
  end
end
