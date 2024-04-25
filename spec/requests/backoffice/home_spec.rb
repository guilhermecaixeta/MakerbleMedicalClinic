require "rails_helper"

RSpec.describe "Backoffice::Homes", type: :request do
  describe "GET /index when user is logged" do
    login_user
    it "returns http success" do
      get "/backoffice/home/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /index when user is not logged" do
    it "returns http return error" do
      get "/backoffice/home/index"
      expect(response).to have_http_status(:redirect)
    end
  end
end
