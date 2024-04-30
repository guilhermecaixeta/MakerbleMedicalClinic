class PatientPolicy < ApplicationPolicy
  def permitted_attributes
    [:name, :birthday, :address, :email, :phone, :avatar]
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      Patient
        .select(:id, :name, :email, :phone)
        .order(:name)
    end
  end
end
