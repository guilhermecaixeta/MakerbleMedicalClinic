FactoryBot.define do
  factory :attendant do
    id { 4 }
    name { "Attendant Test" }
    birthday { "1990-01-01" }
    email { "attendant.test@acme.com" }
    password { "password123" }
    confirmed_at { Time.zone.now - 1.hour }
    confirmation_sent_at { Time.zone.now - 2.hour }
  end
end
