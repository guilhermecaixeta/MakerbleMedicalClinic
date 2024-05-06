require "rails_helper"

RSpec.describe "Backoffice::Statistics", type: :request do
  describe "POST /statistic" do
    before(:example) do
      @headers = { "ACCEPT" => "application/json" }
    end

    it "returns http success when user is manager" do
      FactoryBot.create(:appointment)
      sign_in FactoryBot.create(:manager_with_role)

      get backoffice_statistics_weekly_grown_for_patient_path, :headers => @headers

      expect(response).to have_http_status(:success)
    end

    it "returns http success when user is doctor" do
      doctor = FactoryBot.create(:doctor_with_role)
      FactoryBot.create(:appointment, doctor: doctor)

      sign_in doctor

      get backoffice_statistics_weekly_grown_for_patient_path, :headers => @headers

      expect(response).to have_http_status(:success)
    end

    it "returns http forbidden when user is not authorized" do
      FactoryBot.create(:appointment)
      sign_in FactoryBot.create(:operator_with_role)

      get backoffice_statistics_weekly_grown_for_patient_path, :headers => @headers

      expect(response).to have_http_status(:forbidden)
    end
  end
end
