class Appointment < ApplicationRecord
  belongs_to :doctor, class_name: "User"
  belongs_to :specialty
  belongs_to :patient

  validates :start_date_time, :end_date_time, presence: true
  validates :end_date_time, comparison: { greater_than: :start_date_time }
end
