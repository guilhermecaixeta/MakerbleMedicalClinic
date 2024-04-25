FactoryBot.define do
  factory :patient do
    name { "John Doe" }
    email { "john.doe@patient.com" }
    birthday { Time.now - 18.year }
    phone { "123456" }
    address { "acme street" }
  end
end
