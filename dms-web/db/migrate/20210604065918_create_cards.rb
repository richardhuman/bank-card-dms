# frozen_string_literal: true

class CreateCards < ActiveRecord::Migration[6.1]
  def change
    create_table :cards do |t|
      t.string :card_number, null: false
      t.references :bundle, null: false, foreign_key: { to_table: :card_bundles }
      t.integer :status, null: false
      t.timestamp :sold_at

      t.timestamps
    end
    add_index :cards, :card_number, unique: true
  end
end
