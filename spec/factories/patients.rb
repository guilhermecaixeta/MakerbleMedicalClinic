FactoryBot.define do
  factory :patient do
    trait :duplicate do
      phone { "98765442" }
      email { "john.ddoe@patient.com" }
    end

    name { "John Doe" }
    email { "john.doe@patient.com" }
    birthday { Time.now - 18.year }
    phone { "123456" }
    address { "acme street" }
  end
end
