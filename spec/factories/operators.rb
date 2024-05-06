FactoryBot.define do
  factory :operator do
    name { "Operator Test" }
    birthday { "1990-01-01" }
    email { "operator.test@acme.com" }
    password { "password123" }
    password_confirmation { "password123" }
    confirmed_at { Time.zone.now - 1.hour }
    confirmation_sent_at { Time.zone.now - 2.hour }

    factory :operator_with_role do
      transient do
        roles_count { 1 }
        roles_name { "Operator" }
      end

      after :create do |operator, evaluator|
        create_list(:operator_role, evaluator.roles_count, users: [operator], name: evaluator.roles_name)
        operator.reload
      end
    end
  end
end
