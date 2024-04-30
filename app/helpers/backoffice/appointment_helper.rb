module Backoffice::AppointmentHelper
  def patients_selection
    Patient.select(:id, :name).order(:name)
  end

  def specialties_selection
    Specialty.order(:name).all
  end
end
