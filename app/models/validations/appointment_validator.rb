class Validations::AppointmentValidator < ActiveModel::Validator
  def validate(record)
    appointment_cannot_be_in_the_past record
    appointment_cannot_overlap_existing_one record
  end

  def appointment_cannot_be_in_the_past(record)
    if record.start_date_time.nil? || record.end_date_time.nil?
      return
    end
    today = Time.now

    unless record.id.nil?
      is_past_appointemnt = Appointment.where("end_date_time <= ? AND id = ?", today, record.id).exists?
      record.errors.add(:start_date_time, I18n.t("errors.messages.cant_change_past_appointment")) if is_past_appointemnt
      record.errors.add(:end_date_time, I18n.t("errors.messages.cant_change_past_appointment")) if is_past_appointemnt
    end

    record.errors.add(:start_date_time, I18n.t("errors.messages.cant_be_in_past")) if record.start_date_time < today
    record.errors.add(:end_date_time, I18n.t("errors.messages.cant_be_in_past")) if record.end_date_time < today
  end

  def appointment_cannot_overlap_existing_one(record)
    if record.start_date_time.nil? || record.end_date_time.nil?
      return
    end

    query = <<~EOL
      end_date_time >= :start_date_time
      AND start_date_time <= :end_date_time
      AND (user_id = :user_id OR patient_id = :patient_id)
    EOL

    unless record.id.nil?
      query.prepend "id != :id AND "
    end

    is_overlapping = Appointment.where(query,
                                       { id: record.id,
                                         start_date_time: record.start_date_time,
                                         end_date_time: record.end_date_time,
                                         user_id: record.user_id,
                                         patient_id: record.patient_id })
      .exists?

    if is_overlapping
      record.errors.add(:start_date_time, I18n.t("errors.messages.overlapping_appointment"))
      record.errors.add(:end_date_time, I18n.t("errors.messages.overlapping_appointment"))
    end
  end
end
