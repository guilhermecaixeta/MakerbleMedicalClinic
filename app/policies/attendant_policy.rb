# typed: true
# string_frozen_literal: true

class AttendantPolicy < UserPolicy
  def permitted_attributes
    [:name, :birthday, :email, :password, :password_confirmation, role_ids: []]
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      Attendant.select(:id, :name, :email).distinct.order(:name)
    end
  end
end
