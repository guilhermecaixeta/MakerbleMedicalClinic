module MedicalClinic::AppointmentHelper
  def doctors_selection
    Doctor.select(:id, :name).order(:name).all.map { |doctor| { id: doctor.id, name: doctor.name } }
  end

  def patients_selection
    Patient.select(:id, :name).order(:name).all.map { |patient| { id: patient.id, name: patient.name } }
  end

  def specialties_selection
    Specialty.order(:name).all
  end
end
