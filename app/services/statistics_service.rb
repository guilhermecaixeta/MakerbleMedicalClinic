class StatisticsService
  def self.weekly_grown_for_patient
    last_week_growning_rate_for(Patient)
  end

  def self.weekly_grown_for_appointment
    last_week_growning_rate_for(Appointment)
  end

  def self.monthly_relation_appointments_patients
    end_at = Time.now
    start_at = end_at - 1.months

    patients = Patient.statistics_in_interval(start_at, end_at).to_a
    appointments = Appointment.statistics_in_interval(start_at, end_at).to_a

    current_month = patients.map { |p| p.current_day } | appointments.map { |a| a.current_day }
    monthly_statistics = current_month.map do |day|
      {
        day: day.strftime("%b %d"),
        total_patients: patients&.find { |p| p.current_day == day }&.total || 0,
        total_appointments: appointments&.find { |p| p.current_day == day }&.total || 0,
      }
    end

    { monthly_statistics: monthly_statistics,
      total_patients: patients.sum { |p| p.total },
      total_appointments: appointments.sum { |p| p.total },
      started_at: start_at,
      ended_at: end_at }
  end

  private

  def self.last_week_growning_rate_for(klass)
    end_at = Time.now.to_date
    start_at = end_at - 7.days

    last_week_data = klass.statistics_in_interval(start_at, end_at).to_a
    week_before_data = klass.statistics_in_interval(start_at - 7.days, start_at - 1.days).to_a

    total_last_week = last_week_data&.sum { |p| p.total } || 0
    total_before_last_week = week_before_data&.sum { |p| p.total } || 0

    { statistics_per_day: last_week_data || [],
      statistics_total: total_last_week,
      growning_rate: percent(total_before_last_week.to_f, total_last_week.to_f)}
  end

  def self.percent(value_a, value_b)
    if value_a == 0 && value_b == 0
      return 0
    end
    ((((value_b - value_a) * 100) / value_a).truncate(2))
  end
end
