class Backoffice::StatisticsController < BackofficeController
  before_action :user_can_read?, only: [:weekly_grown_for_patient,
                                        :weekly_grown_for_appointment,
                                        :monthly_relation_appointments_patients]

  before_action :user_can_write?, except: [:weekly_grown_for_patient,
                                           :weekly_grown_for_appointment,
                                           :monthly_relation_appointments_patients]

  def weekly_grown_for_patient
    respond_to do |format|
      format.json { render json: StatisticsService.weekly_grown_for_patient }
    end
  end

  def weekly_grown_for_appointment
    respond_to do |format|
      format.json { render json: StatisticsService.weekly_grown_for_appointment }
    end
  end

  def monthly_relation_appointments_patients
    respond_to do |format|
      format.json { render json: StatisticsService.monthly_relation_appointments_patients }
    end
  end
end
