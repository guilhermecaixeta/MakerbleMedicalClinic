class Specialty < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3, maximum: 255 }
end
