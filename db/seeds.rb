# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
current_datetime = Time.now

if Specialty.all.empty?
  specialties = [{ name: "Allergy and Immunology", created_at: current_datetime, updated_at: current_datetime },
                 { name: "Anesthesiology", created_at: current_datetime, updated_at: current_datetime },
                 { name: "Colon and Rectal Surgery", created_at: current_datetime, updated_at: current_datetime },
                 { name: "Dermatology", created_at: current_datetime, updated_at: current_datetime },
                 { name: "Emergency Medicine", created_at: current_datetime, updated_at: current_datetime },
                 { name: "Family Medicine", created_at: current_datetime, updated_at: current_datetime },
                 { name: "Internal Medicine", created_at: current_datetime, updated_at: current_datetime },
                 { name: "Neurological Surgery", created_at: current_datetime, updated_at: current_datetime },
                 { name: "Nuclear Medicine", created_at: current_datetime, updated_at: current_datetime },
                 { name: "Ophthalmology", created_at: current_datetime, updated_at: current_datetime },
                 { name: "Orthopaedic Surgery", created_at: current_datetime, updated_at: current_datetime },
                 { name: "Pediatrics", created_at: current_datetime, updated_at: current_datetime },
                 { name: "Physical Medicine and Rehabilitation", created_at: current_datetime, updated_at: current_datetime },
                 { name: "Aerospace Medicine", created_at: current_datetime, updated_at: current_datetime }]

  Specialty.upsert_all(specialties)
end

default_roles = [
  { name: "Administrator",
    except_permissions: [] },
  { name: "Doctor",
   except_permissions: ["#{Backoffice::DoctorsController.controller_path}:read",
                        "#{Backoffice::DoctorsController.controller_path}:write",
                        "#{Backoffice::OperatorsController.controller_path}:write",
                        "#{Backoffice::OperatorsController.controller_path}:read",
                        "#{Backoffice::PatientsController.controller_path}:write",
                        "#{Backoffice::AppointmentsController.controller_path}:write",
                        "#{Backoffice::ManagersController.controller_path}:write",
                        "#{Backoffice::ManagersController.controller_path}:read"] },
  { name: "Operator",
   except_permissions: ["#{Backoffice::HomeController.controller_path}:read",
                        "#{Backoffice::StatisticsController.controller_path}:read",
                        "#{Backoffice::OperatorsController.controller_path}:read",
                        "#{Backoffice::OperatorsController.controller_path}:write",
                        "#{Backoffice::DoctorsController.controller_path}:read",
                        "#{Backoffice::DoctorsController.controller_path}:write",
                        "#{Backoffice::ManagersController.controller_path}:write",
                        "#{Backoffice::ManagersController.controller_path}:read"] },
]

if Role.all.empty?
  puts "Adding roles"
  roles = default_roles.map do |role|
    { name: role[:name], created_at: current_datetime, updated_at: current_datetime }
  end
  Role.upsert_all(roles)
  puts "Roles was added!"
end

puts "Checking permissions"
default_permissions = ["#{Backoffice::ManagersController.controller_path}:write",
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

existing_permissions = Permission.all

if existing_permissions.any?
  default_permissions.delete_if do |authorization|
    existing_permissions.any? { |permission| permission.scope.match?(authorization) }
  end
end

if default_permissions.any?
  puts "There is #{default_permissions.count} permissions to be added"
  puts "Adding permissions"
  upsert_permissions = []
  default_permissions.each do |auth|
    upsert_permissions << { title: auth.titleize, scope: auth, created_at: current_datetime, updated_at: current_datetime }
  end
  Permission.upsert_all(upsert_permissions)
  puts "All permissions were added!"
else
  puts "There is no permissions to be added"
end

roles = Role.includes(:permissions).where(name: default_roles.map { |r| r[:name] })

puts "Adding default permissions to roles"
roles.each do |role|
  default_role = default_roles.find { |r| r[:name] == role.name }
  existing_permissions.each do |existing_permission|
    next if role.permissions.any? do |permission_role| permission_role.scope == existing_permission.scope end
    next if default_role[:except_permissions].any? do |exception|
      %r{\A#{exception}}.match?(existing_permission.scope)
    end

    role.permissions << existing_permission
  end
  role.save!(validate: false)
end
puts "Permissions added to roles"
