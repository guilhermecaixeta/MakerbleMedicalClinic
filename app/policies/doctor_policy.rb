# typed: true
# string_frozen_literal: true

class DoctorPolicy < UserPolicy
  def permitted_attributes
    [:name, :birthday, :specialty_id, :email, :password, :password_confirmation, :avatar, role_ids: []]
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      Doctor.includes(:specialty)
        .select(:id, :name, :email, :specialty_id)
        .order(:name)
    end
  end
end
