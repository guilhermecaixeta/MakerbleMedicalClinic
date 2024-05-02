# typed: true
# frozen_string_literal: true

class AppointmentService < ApplicationService
  def create(params)
    @object = Appointment.new(params)

    return apply_changes_if_valid
  end
end
