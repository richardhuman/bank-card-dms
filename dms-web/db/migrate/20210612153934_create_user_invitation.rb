class CreateUserInvitation < ActiveRecord::Migration[6.1]
  def change
    create_table :user_invitations do |t|
      t.references :user, null: false, foreign_key: true
      t.string :invitation_code, null: false
      t.timestamp :expires_at, null: false
      t.timestamp :claimed_at, null: true

      t.timestamps
    end

    add_column :users, :activated_at, :timestamp, null: true
  end
end
