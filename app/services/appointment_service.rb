# typed: true
# frozen_string_literal: true

class AppointmentService
  def self.create(params)
    @appointment = Appointment.new(params)

    if @appointment.valid?
      @appointment.save!
    end

    @appointment
  end

  def self.update(params, appointment)
    @appointment = appointment

    @appointment.assign_attributes(params)

    if @appointment.valid?
      @appointment.save!
    end

    @appointment
  end
end
