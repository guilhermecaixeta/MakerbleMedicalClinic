# typed: true
# frozen_string_literal: true

class ManagerService
  def self.create(params)
    @manager = Manager.new(params)

    if @manager.valid?
      @manager.save!
    end

    @manager.send_confirmation_instructions
    @manager
  end

  def self.update(params, manager)
    @manager = manager
    password = params["password"]
    password_confirmation = params["password_confirmation"]

    if password.blank? && password_confirmation.blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    @manager.assign_attributes(params)

    if @manager.valid?
      @manager.save!
    end

    @manager
  end
end
