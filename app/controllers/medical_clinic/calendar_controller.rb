class MedicalClinic::CalendarController < BackofficeController
  def index
    @appointments = Appointment.get_by_user(current_user.id)
  end
end
