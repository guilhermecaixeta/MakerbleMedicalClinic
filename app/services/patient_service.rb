# typed: true
# frozen_string_literal: true

class PatientService < ApplicationService
  def initialize
    @klass = Patient
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
