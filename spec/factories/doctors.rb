FactoryBot.define do
  factory :doctor do
    name { "Doctor Test" }
    birthday { "1990-01-01" }
    email { "doctor.test@acme.com" }
    password { "password123" }
    password_confirmation { "password123" }
    confirmed_at { Time.zone.now - 1.hour }
    confirmation_sent_at { Time.zone.now - 2.hour }

    specialty factory: :specialty

    after :create do |doctor|
      doctor.skip_confirmation!
    end

    factory :doctor_with_role do
      transient do
        roles_count { 1 }
        roles_name { "Doctor" }
      end

      after :create do |operator, evaluator|
        create_list(:doctor_role, evaluator.roles_count, users: [operator], name: evaluator.roles_name)
        operator.reload
      end
    end
  end
end
