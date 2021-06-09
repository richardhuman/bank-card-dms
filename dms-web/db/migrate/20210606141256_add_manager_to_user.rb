class AddManagerToUser < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :manager, null: true, foreign_key: {  to_table: :users }
    change_table :users do |t|
      t.integer :user_role, null: false
    end
  end
end
