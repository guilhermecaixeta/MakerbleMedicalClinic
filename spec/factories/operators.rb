FactoryBot.define do
  factory :operator do
    id { 4 }
    name { "Operator Test" }
    birthday { "1990-01-01" }
    email { "operator.test@acme.com" }
    password { "password123" }
    confirmed_at { Time.zone.now - 1.hour }
    confirmation_sent_at { Time.zone.now - 2.hour }
  end
end
