class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :mobile_number
      t.string :password_digest
      t.string :first_name
      t.string :surname
      t.timestamp :deleted_at

      t.timestamps
    end
    add_index :users, :email, unique: true
    add_index :users, :mobile_number, unique: true
  end
end
