FactoryBot.define do
  factory :doctor do
    id { 5 }
    name { "Doctor Test" }
    birthday { "1990-01-01" }
    email { "doctor.test@acme.com" }
    password { "password123" }
    confirmed_at { Time.zone.now - 1.hour }
    confirmation_sent_at { Time.zone.now - 2.hour }
  end
end
