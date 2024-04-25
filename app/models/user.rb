class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :trackable

  has_one_attached :avatar
  has_and_belongs_to_many :roles

  validates :name, presence: true, length: { minimum: 3, maximum: 255 }
  validates :birthday, presence: true
end
