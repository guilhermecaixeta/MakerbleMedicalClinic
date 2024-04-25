class AddSpecialtyRefToUsers < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :specialty, null: true, foreign_key: true
  end
end
