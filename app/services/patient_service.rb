# typed: true
# frozen_string_literal: true

class PatientService < ApplicationService
  def create(params)
    @object = Patient.new(params)

    apply_changes_if_valid
  end
end
