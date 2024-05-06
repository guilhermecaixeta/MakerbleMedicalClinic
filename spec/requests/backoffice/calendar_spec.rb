require "rails_helper"

RSpec.describe "Backoffice::Calendars", type: :request do
  describe "POST /calendar" do
    it "returns http success when user is manager" do
      sign_in FactoryBot.create(:manager_with_role)

      FactoryBot.create(:appointment)

      get backoffice_calendar_index_path, params: { start_date: Time.now.at_beginning_of_day,
                                                    end_date: Time.now.at_end_of_day }

      expect(response).to have_http_status(:success)
    end

    it "returns http success when user is operator" do
      sign_in FactoryBot.create(:operator_with_role)

      FactoryBot.create(:appointment)

      get backoffice_calendar_index_path, params: { start_date: Time.now.at_beginning_of_day,
                                                    end_date: Time.now.at_end_of_day }

      expect(response).to have_http_status(:success)
    end

    it "returns http forbidden when user is not authorized" do
      doctor = FactoryBot.create(:doctor)

      sign_in doctor

      FactoryBot.create(:appointment, doctor: doctor)

      get backoffice_calendar_index_path, params: { start_date: Time.now.at_beginning_of_day,
                                                    end_date: Time.now.at_end_of_day }

      expect(response).to have_http_status(:forbidden)
    end
  end
end
