# frozen_string_literal: true

class CreateCardBundles < ActiveRecord::Migration[6.1]
  def change
    create_table :card_bundles do |t|
      t.string :bundle_number, null: false
      t.integer :status, null: false, default: 1
      t.integer :card_quantity, null: false
      t.references :current_assignee, null: true, foreign_key: { to_table: :users }
      t.references :loaded_by, foreign_key: { to_table: :users }
      t.timestamp :loaded_at

      t.timestamps
    end
    add_index :card_bundles, :bundle_number, unique: true
    add_reference :card_bundles, :parent_bundle, foreign_key: { to_table: :users}
  end
end
