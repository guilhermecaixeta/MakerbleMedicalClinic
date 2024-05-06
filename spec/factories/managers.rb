FactoryBot.define do
  factory :manager do
    name { "Support Test" }
    birthday { "1990-01-01" }
    email { "support.test@acme.com" }
    password { "password123" }
    password_confirmation { "password123" }
    confirmed_at { Time.zone.now - 1.hour }
    confirmation_sent_at { Time.zone.now - 2.hour }

    factory :manager_with_role do
      transient do
        roles_count { 1 }
        roles_name { "Administrator" }
      end

      after :create do |manager, evaluator|
        create_list(:administrator_role, evaluator.roles_count, users: [manager], name: evaluator.roles_name)
        manager.reload
      end
    end
  end
end
