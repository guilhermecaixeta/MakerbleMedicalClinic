# typed: true
# frozen_string_literal: true

class AttendantService
  def self.create(params)
    @attendant = Attendant.new(params)

    if @attendant.valid?
      @attendant.save!
    end

    @attendant
  end

  def self.update(params, attendant)
    @attendant = attendant
    password = params["password"]
    password_confirmation = params["password_confirmation"]

    if password.blank? && password_confirmation.blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    @attendant.assign_attributes(params)

    if @attendant.valid?
      @attendant.save!
    end

    @attendant
  end
end
