class Appointment < ApplicationRecord
  belongs_to :doctor, class_name: "User", foreign_key: "user_id"
  belongs_to :specialty
  belongs_to :patient

  validates :start_date_time, :end_date_time, presence: true
  validates :end_date_time, comparison: { greater_than: :start_date_time }

  scope :get_by_user, ->(id) { where("appointment.doctor_id == :id", { id: id }) }
end
