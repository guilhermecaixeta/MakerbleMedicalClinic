class Backoffice::CalendarController < BackofficeController
  def index
    if request.format.json? && (!params[:start_date] || !params[:end_date])
      raise DomainErrors::MissingIntervalError.new
    end
    respond_to do |format|
      start_date = query_params[:start_date]
      end_date = query_params[:end_date]
      if !start_date && !end_date
        format.json { render json: [], status: no_content }
      end
      @appointments = if current_user.roles.any? { |r| r.name == "Doctor" }
          Appointment.get_by_user_in_interval(current_user.id, start_date, end_date)
        else
          Appointment.overlapping_interval(query_params[:start_date], query_params[:end_date])
        end

      format.html
      format.json { render json: @appointments }
    end
  end

  def query_params
    params.permit(:start_date, :end_date)
  end
end
