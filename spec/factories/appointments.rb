FactoryBot.define do
  factory :appointment do
    start_date_time { Time.now + 1.hour }
    end_date_time { Time.now + 2.hour }
    association :patient, factory: :patient
    association :doctor, factory: :doctor
    association :specialty, factory: :specialty
  end
end
