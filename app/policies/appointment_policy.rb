class AppointmentPolicy < ApplicationPolicy
  def permitted_attributes
    [:start_date_time, :end_date_time, :user_id, :patient_id, :specialty_id]
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      Appointment.includes(:doctor, :patient, :specialty)
        .select(:id, :name, :email, :'doctor.name', :'patient.name', :'specialty.name')
        .order(:name)
    end
  end
end
