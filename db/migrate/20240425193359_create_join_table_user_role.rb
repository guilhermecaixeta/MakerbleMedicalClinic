class CreateJoinTableUserRole < ActiveRecord::Migration[7.1]
  def change
    create_join_table :users, :roles do |t|
      t.index [:user_id, :role_id]
    end
  end
end
