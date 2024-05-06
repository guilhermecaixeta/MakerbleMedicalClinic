# typed: true
# frozen_string_literal: true

class UserService < ApplicationService
  def initialize
    @role_name = nil
    super
  end

  protected

  def create(params)
    MissingRoleNameError.new if @role_name.nil?
    MissingParamsError.new if params.nil? || params.empty?

    @object = @klass.new(params)

    @object.role_ids = [Role.select(:id).find_by(name: @role_name).id]
    apply_changes_if_valid lambda { |user| user.send_confirmation_instructions }
  end

  def update(params, object)
    password = params["password"]
    password_confirmation = params["password_confirmation"]

    case [password.blank?, password_confirmation.blank?]
    when [true, true]
      params.delete(:password)
      params.delete(:password_confirmation)
    when [true, false]
      object.errors.add :password,
                        I18n.t("errors.messages.blank")
    when [false, true]
      object.errors.add :password_confirmation,
                        I18n.t("errors.messages.blank")
    end

    super params, object
  end
end
