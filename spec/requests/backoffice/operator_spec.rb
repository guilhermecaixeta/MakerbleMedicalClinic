require "rails_helper"

RSpec.describe "Backoffice::Operators", type: :request do
  describe "GET /index" do
    it "returns http success when user is manager" do
      sign_in FactoryBot.create(:manager_with_role)
      get backoffice_operators_path
      expect(response).to have_http_status(:ok)
    end

    it "returns http forbidden when user is not manager" do
      sign_in FactoryBot.create(:operator_with_role)
      get backoffice_operators_path
      expect(response).to have_http_status(:forbidden)
    end

    it "redirect http when not loggedin" do
      get backoffice_operators_path
      expect(response).to redirect_to(new_user_session_url)
    end
  end

  describe "POST /operator" do
    it "returns http success when user is manager" do
      FactoryBot.create(:role, name: "Operator")
      sign_in FactoryBot.create(:manager_with_role)

      user_attributes = FactoryBot.attributes_for(:operator, email: "some.user@acme.com")

      post backoffice_operators_path, params: { operator: user_attributes }

      expect(response).to redirect_to(backoffice_operators_path)
    end

    it "returns http forbidden when user is not manager" do
      FactoryBot.create(:role, name: "Operator")
      sign_in FactoryBot.create(:doctor_with_role)

      user_attributes = FactoryBot.attributes_for(:operator, email: "some.user@acme.com")

      post backoffice_operators_path, params: { operator: user_attributes }

      expect(response).to have_http_status(:forbidden)
    end
  end

  describe "PUT /operator" do
    it "returns http success when user is self" do
      operator = FactoryBot.create(:operator_with_role)
      sign_in operator

      put backoffice_operator_path(operator), params: { action: "update",
                                                        operator: { name: "John Cena" } }
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(backoffice_calendar_index_path)
    end

    it "returns http success when user is manager" do
      manager = FactoryBot.create(:manager_with_role)
      operator = FactoryBot.create(:operator_with_role)
      sign_in manager

      put backoffice_operator_path(operator), params: { action: "update",
                                                        operator: { name: "John Cena" } }
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(backoffice_operators_path)
    end

    it "returns http forbidden when user is not manager or self" do
      sign_in FactoryBot.create(:operator_with_role)
      operator = FactoryBot.create(:operator_with_role, email: "some.user@acme.com")

      put backoffice_operator_path(operator), params: { operator: { name: "John Cena" } }

      expect(response).to have_http_status(:forbidden)
    end

    it "returns http success when password and password confirmation are correctly" do
      manager = FactoryBot.create(:manager_with_role)
      operator = FactoryBot.create(:operator_with_role)
      sign_in manager

      put backoffice_operator_path(operator), params: { action: "update",
                                                       operator: { name: "John Cena",
                                                                   password: "123456",
                                                                   password_confirmation: "123456" } }
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(backoffice_operators_path)
    end

    it "returns http unprocessable entity when password confirmation is missing" do
      manager = FactoryBot.create(:manager_with_role)
      operator = FactoryBot.create(:operator_with_role)
      sign_in manager

      put backoffice_operator_path(operator), params: { action: "update",
                                                        operator: { name: "John Cena", password: "123456" } }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "returns http unprocessable entity when password and password confirmation doesnt match" do
      manager = FactoryBot.create(:manager_with_role)
      operator = FactoryBot.create(:operator_with_role)
      sign_in manager

      put backoffice_operator_path(operator), params: { action: "update",
                                                       operator: { name: "John Cena",
                                                                   password: "123456",
                                                                   password_confirmation: "654321" } }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "DELETE /operator" do
    it "returns http success" do
      manager = FactoryBot.create(:manager_with_role)
      sign_in manager
      operator = FactoryBot.create(:operator_with_role, email: "some.user@acme.com")

      get backoffice_operators_path

      delete backoffice_operator_path(operator)

      expect(response).to have_http_status(:redirect)
    end

    it "returns http forbidden" do
      sign_in FactoryBot.create(:operator_with_role)
      role = FactoryBot.create(:role)
      user = FactoryBot.create(:operator, email: "some.user@acme.com", roles: [role])

      delete backoffice_operator_path(user)

      expect(response).to have_http_status(:forbidden)
    end
  end
end
