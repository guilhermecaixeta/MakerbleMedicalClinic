# typed: true
# frozen_string_literal: true

class OperatorService < UserService
  def initialize
    super
    @role_name = "Operator"
    @klass = Operator
  end

  def create(params)
    super params
  end

  def update(params, object)
    super params, object
  end

  def destroy(params)
    super params
  end
end
