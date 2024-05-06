class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable, :confirmable

  has_one_attached :avatar
  has_and_belongs_to_many :roles

  validates :name, presence: true, length: { minimum: 3, maximum: 255 }
  validates :birthday, presence: true, comparison: { less_than_or_equal_to: Time.now }
  validates :password, confirmation: true, on: [:create, :update]
  validates :password_confirmation, presence: true, on: [:create, :update], unless: Proc.new { |it| it.password.blank? }

  def is_doctor?
    self.roles.where(name: "Doctor").exists?
  end

  def is_operator?
    self.roles.where(name: "Operator").exists?
  end

  def is_admin?
    self.roles.where(name: "Administrator").exists?
  end
end
