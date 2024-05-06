FactoryBot.define do
  factory :role do
    name { "Administrator" }

    factory :administrator_role do
      transient do
        permissions {
          ["#{Backoffice::ManagersController.controller_path}:write",
           "#{Backoffice::ManagersController.controller_path}:read",
           "#{Backoffice::HomeController.controller_path}:read",
           "#{Backoffice::StatisticsController.controller_path}:read",
           "#{Backoffice::DoctorsController.controller_path}:read",
           "#{Backoffice::DoctorsController.controller_path}:write",
           "#{Backoffice::OperatorsController.controller_path}:write",
           "#{Backoffice::OperatorsController.controller_path}:read",
           "#{Backoffice::CalendarController.controller_path}:write",
           "#{Backoffice::CalendarController.controller_path}:read",
           "#{Backoffice::PatientsController.controller_path}:write",
           "#{Backoffice::PatientsController.controller_path}:read",
           "#{Backoffice::AppointmentsController.controller_path}:write",
           "#{Backoffice::AppointmentsController.controller_path}:read",
           "#{Devise::SessionsController.controller_path}:write"]
        }
      end

      after :create do |role, evaluator|
        evaluator.permissions.each do |permission|
          create_list(:permission, 1, roles: [role], scope: permission, title: permission)
        end
        role.reload
      end
    end

    factory :operator_role do
      name { "Operator" }

      transient do
        permissions {
          ["#{Backoffice::CalendarController.controller_path}:write",
           "#{Backoffice::CalendarController.controller_path}:read",
           "#{Backoffice::PatientsController.controller_path}:write",
           "#{Backoffice::PatientsController.controller_path}:read",
           "#{Backoffice::AppointmentsController.controller_path}:write",
           "#{Backoffice::AppointmentsController.controller_path}:read",
           "#{Devise::SessionsController.controller_path}:write"]
        }
      end

      after :create do |role, evaluator|
        evaluator.permissions.each do |permission|
          create_list(:permission, 1, roles: [role], scope: permission, title: permission)
        end
        role.reload
      end
    end

    factory :doctor_role do
      name { "Doctor" }

      transient do
        permissions {
          ["#{Backoffice::HomeController.controller_path}:read",
           "#{Backoffice::StatisticsController.controller_path}:read",
           "#{Backoffice::CalendarController.controller_path}:write",
           "#{Backoffice::CalendarController.controller_path}:read",
           "#{Backoffice::PatientsController.controller_path}:read",
           "#{Backoffice::AppointmentsController.controller_path}:read",
           "#{Devise::SessionsController.controller_path}:write"]
        }
      end

      after :create do |role, evaluator|
        evaluator.permissions.each do |permission|
          create_list(:permission, 1, roles: [role], scope: permission, title: permission)
        end
        role.reload
      end
    end
  end
end
