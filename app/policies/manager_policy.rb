# typed: true
# string_frozen_literal: true

class ManagerPolicy < UserPolicy
  def permitted_attributes
    [:name, :birthday, :email, :password, :password_confirmation, :avatar, role_ids: []]
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      Manager.left_outer_joins(:roles)
        .select(:id, :name, :email)
        .distinct
        .order(:name)
    end
  end
end
