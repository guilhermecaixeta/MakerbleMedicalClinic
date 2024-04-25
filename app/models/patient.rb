class Patient < ApplicationRecord
  has_many :appointments

  validates :name, :email, :birthday, :address, :phone, presence: true
  validates :name, length: { minimum: 3, maximum: 255 }
  validates :email, length: { minimum: 3, maximum: 255 }, uniqueness: true
  validates :phone, length: { minimum: 3, maximum: 12 }, uniqueness: true
  validates :address, length: { minimum: 3, maximum: 255 }
  validates :birthday, comparison: { less_than_or_equal_to: Time.now }
end
