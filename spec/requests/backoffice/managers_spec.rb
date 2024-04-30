require 'rails_helper'

RSpec.describe "Backoffice::Managers", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/backoffice/managers/index"
      expect(response).to have_http_status(:success)
    end
  end

end
