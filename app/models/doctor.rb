class Doctor < User
  belongs_to :specialty
  has_many :appointments, class_name: "Appointment", foreign_key: "doctor_id"
end
