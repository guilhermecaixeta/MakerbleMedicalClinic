class Backoffice::StatisticsController < BackofficeController
  def weekly_for_patient
    respond_to do |format|
      format.json { render json: DashboardService.metrics_for_last_week_patients }
    end
  end

  def show_metrics_for_appointments
    respond_to do |format|
      format.json { render json: Appointment.new_appointments_for_the_last_week }
    end
  end
end
