FactoryBot.define do
  factory :appointment do
    start_date_time { Time.now + 1.hour }
    end_date_time { Time.now + 2.hour }
    specialty factory: :specialty
    patient factory: :patient
    doctor factory: :doctor

    trait :concurrent do
      association :patient, factory: [:patient, :duplicate]
    end
  end
end
