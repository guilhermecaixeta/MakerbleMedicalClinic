class Backoffice::CalendarController < BackofficeController
  def index
    if request.format.json? && (!params[:start_date] || !params[:end_date])
      raise DomainErrors::MissingIntervalError.new
    end
    respond_to do |format|
      @appointments = if current_user.roles.any? { |r| r.name == "Doctor" }
          Appointment.get_by_user(current_user.id, params[:start_date], params[:end_date])
        else
          Appointment.overlapping_interval(params[:start_date], params[:end_date])
        end

      format.html
      format.json { render json: @appointments }
    end
  end
end
