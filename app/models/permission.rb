class Permission < ApplicationRecord
  has_and_belongs_to_many :roles

  validates :title, :scope, presence: true
  validates :title, length: { minimum: 3, maximum: 255 }
  validates :scope, length: { minimum: 3, maximum: 400 }
end
