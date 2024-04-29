class Patient < ApplicationRecord
  has_many :appointments

  validates :name, :email, :birthday, :address, :phone, presence: true
  validates :name, length: { minimum: 3, maximum: 255 }
  validates :email, length: { minimum: 3, maximum: 255 }, uniqueness: true
  validates :phone, length: { minimum: 3, maximum: 25 }, uniqueness: true
  validates :address, length: { minimum: 3, maximum: 255 }
  validates :birthday, comparison: { less_than_or_equal_to: Time.now }

  scope :metrics_for_new_patients_in_interval, ->(start_at, end_at) {
          date_range = start_at..end_at
          where(:created_at => date_range)
            .group("date")
            .select("COUNT(id) as total, date_trunc('day', created_at::date) as date")
            .order(:date)
        }
end
