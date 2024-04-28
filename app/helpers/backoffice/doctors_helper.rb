module Backoffice::DoctorsHelper
  def specialties_selection
    Specialty.order(:name).all
  end
end
