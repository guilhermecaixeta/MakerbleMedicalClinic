class Backoffice::DoctorsController < BackofficeController
  # before_action :user_can_read?, only: [:filter_by_specialty]

  def index
    super
  end

  def filter_by_specialty
    respond_to do |format|
      doctors = Doctor.filter_by_specialty query_params[:specialty_id]
      if doctors.any?
        @selected_doctor = query_params[:selected_doctor_id]
        @doctors = doctors
      else
        flash.now[:error] = "There is not doctors found with this specialty"
      end
      format.turbo_stream
    end
  end

  def new
    super
  end

  def create
    super
  end

  def edit
    super
  end

  def update
    super
  end

  def destroy
    super
  end

  def get_default_path
    backoffice_doctors_path
  end

  def query_params
    params.permit(:specialty_id, :selected_doctor_id)
  end
end
