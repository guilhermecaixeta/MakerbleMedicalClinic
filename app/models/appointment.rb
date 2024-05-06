class Appointment < ApplicationRecord
  belongs_to :doctor, class_name: "Doctor", foreign_key: "user_id"
  belongs_to :specialty
  belongs_to :patient

  validates :start_date_time, :end_date_time, presence: true
  validates :end_date_time, comparison: { greater_than: :start_date_time }
  validates_with Validations::AppointmentValidator, only: [:create, :update]

  scope :get_by_user_in_interval, ->(id, start_date, end_date) {
          where("appointments.user_id = :id", { id: id })
            .overlapping_interval(start_date, end_date)
        }

  scope :overlapping_interval, ->(start_date, end_date) {
      query = <<~EOL
            end_date_time >= :start_date
            AND start_date_time <= :end_date
          EOL
      where(query,
            { start_date: start_date, end_date: end_date })
        .get_appointments_for_calendar
    }
  scope :get_appointments_for_calendar, -> {
          joins(:doctor, :patient, :specialty)
            .select("id",
                    "start_date_time",
                    "end_date_time",
                    "users.name as doctor_name",
                    "patients.name as patient_name",
                    "specialties.name as specialty_name")
            .map do |appointment|
            {
              id: appointment.id,
              title: "#{appointment.doctor_name} - #{appointment.specialty_name}",
              extendedProps: { doctor_name: appointment.doctor_name,
                               patient_name: appointment.patient_name,
                               specialty_name: appointment.specialty_name },
              start: appointment.start_date_time,
              end: appointment.end_date_time,
            }
          end
        }

  scope :statistics_in_interval, ->(start_at, end_at) {
          date_range = start_at..end_at
          where(:start_date_time => date_range)
            .group("current_day")
            .select("COUNT(id) as total, date_trunc('day', start_date_time::date) as current_day")
            .order(:current_day)
        }
end
