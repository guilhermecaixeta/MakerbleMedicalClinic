# typed: true
# frozen_string_literal: true

class OperatorService
  def self.create(params)
    @operator = Operator.new(params)

    if @operator.valid?
      @operator.role_ids = [Role.find_by(name: "Operator").id]

      @operator.save!
    end

    @operator
  end

  def self.update(params, operator)
    @operator = operator
    password = params["password"]
    password_confirmation = params["password_confirmation"]

    if password.blank? && password_confirmation.blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    @operator.assign_attributes(params)

    if @operator.valid?
      @operator.save!
    end

    @operator
  end
end
