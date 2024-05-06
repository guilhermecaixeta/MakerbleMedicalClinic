require "rails_helper"

RSpec.describe "Backoffice::Homes", type: :request do
  describe "GET /index when user is logged" do
    it "returns http success" do
      sign_in FactoryBot.create :manager_with_role
      get root_path

      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /index when user is not logged" do
    it "returns http return error" do
      get root_path

      expect(response).to have_http_status(:redirect)
    end
  end
end
