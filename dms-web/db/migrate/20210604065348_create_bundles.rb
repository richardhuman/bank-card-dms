# frozen_string_literal: true

class CreateBundles < ActiveRecord::Migration[6.1]
  def change
    create_table :bundles do |t|
      t.string :bundle_number, null: false
      t.integer :status, null: false, default: 1
      t.integer :current_quantity, null: false, default: 0
      t.integer :initial_quantity, null: false, default: 0
      t.references :current_assignee, null: true, foreign_key: { to_table: :users }
      t.references :loaded_by, foreign_key: { to_table: :users }
      t.timestamp :loaded_at

      t.timestamps
    end
    add_index :bundles, :bundle_number, unique: true
    add_reference :bundles, :parent_bundle, foreign_key: { to_table: :users }
  end
end
