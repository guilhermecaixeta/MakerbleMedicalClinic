class Appointment < ApplicationRecord
  belongs_to :doctor, class_name: "User", foreign_key: "user_id"
  belongs_to :specialty
  belongs_to :patient

  validates :start_date_time, :end_date_time, presence: true
  validates :end_date_time, comparison: { greater_than: :start_date_time }

  scope :get_by_user_in_interval, ->(id, start_date, end_date) {
          overlapping_interval(start_date, end_date)
            .where("appointment.doctor_id == :id", { id: id })
            .get_appointments_for_calendar
        }
  scope :overlapping_interval, ->(start_date, end_date) {
      query = <<~EOL
            end_date_time >= :start_date
            AND start_date_time <= :end_date
          EOL
      includes(:doctor, :patient, :specialty)
        .where(query,
               { start_date: start_date, end_date: end_date })
        .get_appointments_for_calendar
    }
  scope :get_appointments_for_calendar, -> {
          map do |appointment|
            {
              id: appointment.id,
              title: "#{appointment.doctor.name} - #{appointment.doctor.specialty.name}",
              extendedProps: { doctor: appointment.doctor,
                               patient: appointment.patient,
                               specialty: appointment.doctor.specialty.name },
              start: appointment.start_date_time,
              end: appointment.end_date_time,
            }
          end
        }
end
