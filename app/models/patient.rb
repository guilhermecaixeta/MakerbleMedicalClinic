class Patient < ApplicationRecord
  has_many :appointments, dependent: :delete_all

  has_one_attached :avatar

  has_one_attached :avatar

  validates :name, :email, :birthday, :address, :phone, presence: true
  validates :name, length: { minimum: 3, maximum: 255 }
  validates :email, length: { minimum: 3, maximum: 255 }, uniqueness: true
  validates :phone, length: { minimum: 3, maximum: 25 }, uniqueness: true
  validates :address, length: { minimum: 3, maximum: 255 }
  validates :birthday, comparison: { less_than_or_equal_to: Time.now }

  scope :statistics_in_interval, ->(start_at, end_at) {
          date_range = start_at..end_at
          where(:created_at => date_range)
            .group("current_day")
            .select("COUNT(id) as total, date_trunc('day', created_at::date) as current_day")
            .order(:current_day)
        }
end
