class Permission < ApplicationRecord
  validates :title, :scope, presence: true
  validates :title, length: { minimum: 3, maximum: 255 }
  validates :scope, length: { minimum: 3, maximum: 400 }
end
