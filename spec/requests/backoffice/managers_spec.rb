require "rails_helper"

RSpec.describe "Backoffice::Managers", type: :request do
  describe "GET /index" do
    it "returns http success when user is manager" do
      sign_in FactoryBot.create(:manager_with_role)
      get backoffice_managers_path
      expect(response).to have_http_status(:success)
    end

    it "returns http forbidden when user is not manager" do
      sign_in FactoryBot.create(:operator_with_role)
      get backoffice_managers_path
      expect(response).to have_http_status(:forbidden)
    end

    it "redirect http when not loggedin" do
      get backoffice_managers_path
      expect(response).to redirect_to(new_user_session_url)
    end
  end

  describe "POST /manager" do
    it "returns http success when user is manager" do
      sign_in FactoryBot.create(:manager_with_role)
      role = FactoryBot.create(:role)
      user_attributes = FactoryBot.attributes_for(:manager, email: "some.user@acme.com", roles: [role])

      post backoffice_managers_path, params: { manager: user_attributes }

      expect(response).to redirect_to(backoffice_managers_path)
    end

    it "returns http forbidden when user is not manager" do
      sign_in FactoryBot.create(:operator_with_role)
      role = FactoryBot.create(:role)
      user_attributes = FactoryBot.attributes_for(:manager, email: "some.user@acme.com", roles: [role])
      user_attributes[:password_confirmation] = user_attributes[:password]

      post backoffice_managers_path, params: { manager: user_attributes }

      expect(response).to have_http_status(:forbidden)
    end
  end

  describe "PUT /manager" do
    it "returns http success when user is manager" do
      manager = FactoryBot.create(:manager_with_role)
      sign_in manager
      role = FactoryBot.create(:role)
      user = FactoryBot.create(:manager, email: "some.user@acme.com", roles: [role])

      put backoffice_manager_path(user), params: { manager: { name: "John Cena" } }

      expect(response).to redirect_to(backoffice_managers_path)
    end

    it "returns http forbidden when user is not manager" do
      sign_in FactoryBot.create(:operator_with_role)
      role = FactoryBot.create(:role)
      user = FactoryBot.create(:manager, email: "some.user@acme.com", roles: [role])

      put backoffice_manager_path(user), params: { manager: { name: "John Cena" } }

      expect(response).to have_http_status(:forbidden)
    end
  end

  describe "DELETE /manager" do
    it "returns http success when user is manager" do
      manager = FactoryBot.create(:manager_with_role)
      sign_in manager
      role = FactoryBot.create(:role)
      user = FactoryBot.create(:manager, email: "some.user@acme.com", roles: [role])

      get backoffice_managers_path

      delete backoffice_manager_path(user)

      expect(response).to redirect_to(root_path)
    end

    it "returns http forbidden when user is not manager" do
      sign_in FactoryBot.create(:operator_with_role)
      role = FactoryBot.create(:role)
      user = FactoryBot.create(:manager, email: "some.user@acme.com", roles: [role])

      delete backoffice_manager_path(user)

      expect(response).to have_http_status(:forbidden)
    end
  end
end
