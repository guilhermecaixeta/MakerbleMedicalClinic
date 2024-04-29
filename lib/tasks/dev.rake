namespace :dev do
  task setup: :environment do
    puts "Dropping DB #{%x(rails db:drop)}"
    puts "Creating DB #{%x(rails db:create)}"
    puts "Migrating DB #{%x(rails db:migrate)}"
    puts "Seeding DB #{%x(rails db:seed)}"
    puts "Adding doctors #{%x(rails dev:doctors_generator)}"
    puts "Adding operators #{%x(rails dev:operators_generator)}"
    puts "Adding operators #{%x(rails dev:patients_generator)}"
    puts "Adding operators #{%x(rails dev:appointments_generator)}"
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

      user.avatar.attach(
        io: URI.open(Faker::LoremFlickr.unique.image(size: "1080x1080", search_terms: ["doctor", "person", "smile", "avatar"])),
        filename: "#{user.id}.jpg",
      )
      Faker::LoremFlickr.unique.clear
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

      user.avatar.attach(
        io: URI.open(Faker::LoremFlickr.unique.image(size: "800x800", search_terms: ["recepcionist", "person"])),
        filename: "#{user.id}.jpg",
      )
      Faker::LoremFlickr.unique.clear
      user.save!
    end
    puts "Operators generated"
  end

  desc "Generate Patients"
  task patients_generator: :environment do
    number_of_users = 45
    puts "Generating #{number_of_users} patients"
    patients = []
    number_of_users.times do
      creation_date = DateTime::now - rand(45).day
      patients << {
        name: Faker::Name.name,
        birthday: Faker::Date.birthday,
        email: Faker::Internet.email,
        address: Faker::Address.full_address,
        phone: Faker::PhoneNumber.phone_number,
        created_at: creation_date,
        updated_at: creation_date,
      }
    end

    Patient.upsert_all(patients)
    puts "Patients generated"
  end

  desc "Generate Appointments"
  task appointments_generator: :environment do
    number_of_appointments = 100
    puts "Generating #{number_of_appointments} appointments"
    patients = Patient.all
    doctors = Doctor.includes(:specialty).all
    creation_date = DateTime::now
    appointments = []
    number_of_appointments.times do
      start_at = Faker::Date.between(from: creation_date - 15.days, to: creation_date + 1.month) + rand(1..24).hours
      end_at = start_at + rand(15..180).minutes
      doctor = doctors.shuffle.sample
      appointments << { start_date_time: start_at,
                        end_date_time: end_at,
                        user_id: doctor.id,
                        specialty_id: doctor.specialty.id,
                        patient_id: patients.shuffle.sample.id,
                        updated_at: creation_date,
                        created_at: creation_date }
    end

    Appointment.upsert_all appointments
    puts "Appointments generated"
  end
end
