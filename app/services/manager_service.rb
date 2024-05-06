# typed: true
# frozen_string_literal: true

class ManagerService < UserService
  def initialize
    super
    @role_name = "Administrator"
    @klass = Manager
  end

  def create(params)
    MissingParamsError.new if params.nil? || params.empty?

    @object = @klass.new(params)

    apply_changes_if_valid lambda { |user| user.send_confirmation_instructions }
  end

  def update(params, object)
    super params, object
  end

  def destroy(params)
    super params
  end
end
