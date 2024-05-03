class Role < ApplicationRecord
  has_and_belongs_to_many :users
  has_and_belongs_to_many :permissions

  validates :name, presence: true, length: { minimum: 3, maximum: 255 }
end
