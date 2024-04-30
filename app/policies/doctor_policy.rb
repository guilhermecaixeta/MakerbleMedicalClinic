# typed: true
# string_frozen_literal: true

class DoctorPolicy < UserPolicy
  def permitted_attributes
    [:name, :birthday, :specialty_id, :email, :password, :password_confirmation, :avatar]
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      Doctor.joins(:specialty)
        .select("users.id", "users.name", "users.email", "specialties.name as specialty_name")
        .order(:name)
    end
  end
end
