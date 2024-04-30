# typed: true
# frozen_string_literal: true

class DoctorService
  def self.create(params)
    @doctor = Doctor.new(params)

    if @doctor.valid?
      @doctor.role_ids = [Role.find_by(name: "Doctor").id]

      @doctor.save!
    end

    @doctor.send_confirmation_instructions
    @doctor
  end

  def self.update(params, doctor)
    @doctor = doctor
    password = params["password"]
    password_confirmation = params["password_confirmation"]

    if password.blank? && password_confirmation.blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    @doctor.assign_attributes(params)

    if @doctor.valid?
      @doctor.save!
    end

    @doctor
  end
end
