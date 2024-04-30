class AppointmentPolicy < ApplicationPolicy
  def permitted_attributes
    [:start_date_time, :end_date_time, :user_id, :patient_id, :specialty_id]
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      if @user.is_doctor?
        Appointment.joins(:doctor, :patient, :specialty)
          .where(user_id: user.id)
          .select("appointments.id",
                  "appointments.start_date_time",
                  "appointments.end_date_time",
                  "users.name as doctor_name",
                  "patients.name as patient_name",
                  "specialties.name as specialty_name")
          .order("appointments.start_date_time")
      else
        Appointment.joins(:doctor, :patient, :specialty)
          .select("appointments.id",
                  "appointments.start_date_time",
                  "appointments.end_date_time",
                  "users.name as doctor_name",
                  "patients.name as patient_name",
                  "specialties.name as specialty_name")
          .order("appointments.start_date_time")
      end
    end
  end
end
