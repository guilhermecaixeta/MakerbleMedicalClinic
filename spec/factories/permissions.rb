FactoryBot.define do
  factory :permission do
    title { "[Write]#{Backoffice::HomeController.controller_path}" }
    scope { "#{Backoffice::HomeController.controller_path}:write" }
  end
end
