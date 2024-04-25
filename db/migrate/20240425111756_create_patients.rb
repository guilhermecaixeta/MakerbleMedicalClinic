class CreatePatients < ActiveRecord::Migration[7.1]
  def change
    create_table :patients do |t|
      t.string :name, null: false, limit: 255
      t.string :email, null: false, limit: 255
      t.datetime :birthday, null: false
      t.string :phone, null: false, limit: 12
      t.string :address, null: false, limit: 255

      t.timestamps
    end
  end
end
