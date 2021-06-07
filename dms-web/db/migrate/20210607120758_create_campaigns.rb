class CreateCampaigns < ActiveRecord::Migration[6.1]
  def change
    create_table :campaigns do |t|
      t.string :title, null: false
      t.string :description, limit: 2000
      t.references :created_by, null: true, foreign_key: { to_table: "users" }

      t.timestamps
    end
  end
end
