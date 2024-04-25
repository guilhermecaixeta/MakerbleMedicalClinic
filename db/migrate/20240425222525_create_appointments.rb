class CreateAppointments < ActiveRecord::Migration[7.1]
  def change
    create_table :appointments do |t|
      t.datetime :start_date_time, null: false
      t.datetime :end_date_time, null: false
      t.references :user, null: false, foreign_key: true
      t.references :patient, null: false, foreign_key: true
      t.references :specialty, null: false, foreign_key: true

      t.timestamps
    end
  end
end
