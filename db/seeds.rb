# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
currentTime = Time.now

if Manager.all.empty?
  puts "Adding admin master"
  default_password = Rails.configuration.default_password
  user = Manager.create(
    name: "Admin master",
    birthday: "1990-01-01",
    email: "admin.master@acme.com",
    password: default_password,
    password_confirmation: default_password,
    confirmed_at: currentTime,
  )
  user.skip_confirmation!
  user.skip_confirmation_notification!
  puts "Admin master was added!"
end

if Role.all.empty?
  puts "Adding roles"
  roles = [{ name: "Admin", created_at: currentTime, updated_at: currentTime },
           { name: "Doctor", created_at: currentTime, updated_at: currentTime },
           { name: "Attendant", created_at: currentTime, updated_at: currentTime },
           { name: "Patient", created_at: currentTime, updated_at: currentTime }]
  Role.upsert_all(roles)
  puts "Roles was added!"
end

if Permission.all.empty?
  puts "Adding permissions"
  permissions = [{ title: "[Write]:#{Backoffice::HomeController.controller_path}",
                   scope: "#{Backoffice::HomeController.controller_path}:write",
                   created_at: currentTime,
                   updated_at: currentTime },
                 { title: "[Read]:#{Backoffice::HomeController.controller_path}",
                   scope: "#{Backoffice::HomeController.controller_path}:read",
                   created_at: currentTime,
                   updated_at: currentTime }]

  Permission.upsert_all(permissions)
  puts "Permissions was added!"
end
