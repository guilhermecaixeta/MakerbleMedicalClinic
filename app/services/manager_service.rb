# typed: true
# frozen_string_literal: true

class ManagerService < ApplicationService
  def create(params)
    @object = Manager.new(params)

    apply_changes_if_valid success_callback: lambda { |manager| manager.send_confirmation_instructions }
  end

  def update(params, object)
    password = params["password"]
    password_confirmation = params["password_confirmation"]

    if password.blank? && password_confirmation.blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    super params, object
  end
end
