class DashboardService
  def self.metrics_for_last_week_patients
    beginning_of_week = Time.now.at_beginning_of_week
    start_at = beginning_of_week - 7.days
    end_at = beginning_of_week - 1.days

    last_week_patients = Patient.metrics_for_new_patients_in_interval(start_at, end_at).to_a
    week_before_patients = Patient.metrics_for_new_patients_in_interval(start_at - 7.days, start_at - 1.days).to_a

    total_last_week = last_week_patients.sum { |p| p.total }
    total_before_last_week = week_before_patients.sum { |p| p.total }

    { statistics_per_day: last_week_patients,
      statistics_total: total_last_week,
      growning: percent(total_before_last_week.to_f, total_last_week.to_f) }
  end

  private

  def self.percent(value_a, value_b)
    ((value_b - value_a) * 100.to_f) / value_a
  end
end
