class Doctor < User
  belongs_to :specialty
  has_many :appointments, class_name: "Appointment", foreign_key: "user_id", dependent: :delete_all

  scope :filter_by_specialty, ->(specialty_id) { select(:id, :name).where(specialty_id: specialty_id) }
end
