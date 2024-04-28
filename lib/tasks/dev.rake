namespace :dev do
  task setup: :environment do
    puts "Dropping DB #{%x(rails db:reset)}"
    puts "Adding doctors #{%x(rails dev:doctors_generator)}"
    puts "Adding operators #{%x(rails dev:operators_generator)}"
    puts "Fixing pk sequence"
    ActiveRecord::Base.connection.tables.each do |table_name|
      ActiveRecord::Base.connection.reset_pk_sequence!(table_name)
    end
  end

  desc "Generate doctors"
  task doctors_generator: :environment do
    number_of_users = 50
    doctor_role = Role.find_by(name: "Doctor")
    specialties = Specialty.all
    default_password = Rails.configuration.default_password

    puts "Generating #{number_of_users} doctors"
    utc_now = DateTime::now
    number_of_users.times do
      user = Doctor.create!(
        name: Faker::Name.name,
        birthday: Faker::Date.birthday,
        email: Faker::Internet.email,
        password: default_password,
        password_confirmation: default_password,
        confirmed_at: utc_now,
        role_ids: [doctor_role.id],
        specialty_id: specialties.shuffle.sample.id,
      )

      user.skip_confirmation!
      user.skip_confirmation_notification!

      # user.avatar.attach(
      #   io: open(Faker::LoremFlickr.unique.image(search_terms: ["doctor", "person", "smile", "avatar", "high resolution"])),
      #   filename: "#{user.id}.jpg",
      # )
      # Faker::LoremFlickr.unique.clear
      user.save!
    end
    puts "Doctors generated"
  end

  desc "Generate operators"
  task operators_generator: :environment do
    number_of_users = 15
    operator_role = Role.find_by(name: "Operator")
    default_password = Rails.configuration.default_password
    puts "Generating #{number_of_users} operators"
    utc_now = DateTime::now
    number_of_users.times do
      user = Attendant.create!(
        name: Faker::Name.name,
        birthday: Faker::Date.birthday,
        email: Faker::Internet.email,
        password: default_password,
        password_confirmation: default_password,
        confirmed_at: utc_now,
        role_ids: [operator_role.id],
      )
      user.skip_confirmation!
      user.skip_confirmation_notification!

      # user.avatar.attach(
      #   io: open(Faker::LoremFlickr.unique.image(search_terms: ["recepcionist", "person", "smile", "avatar", "high resolution"])),
      #   filename: "#{user.id}.jpg",
      # )
      # Faker::LoremFlickr.unique.clear
      user.save!
    end
    puts "Operators generated"
  end
end
