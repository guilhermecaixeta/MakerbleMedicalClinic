# typed: true
# frozen_string_literal: true

class DoctorService < UserService
  def initialize
    super
    @role_name = "Doctor"
    @klass = Doctor
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
