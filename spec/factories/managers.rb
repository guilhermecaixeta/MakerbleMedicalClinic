FactoryBot.define do
  factory :manager do
    id { 3 }
    name { "Support Test" }
    birthday { "1990-01-01" }
    email { "support.test@acme.com" }
    password { "password123" }
    confirmed_at { Time.zone.now - 1.hour }
    confirmation_sent_at { Time.zone.now - 2.hour }
  end
end
