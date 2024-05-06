# typed: true
# string_frozen_literal: true

class OperatorPolicy < UserPolicy
  def permitted_attributes
    [:name, :birthday, :email, :password, :password_confirmation, :avatar]
  end

  def has_read_and_write_permission?
    true
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      Operator.select(:id, :name, :email).distinct.order(:name)
    end
  end
end
