# frozen_string_literal: true

class CreateCardBundleTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :card_bundle_transactions do |t|
      t.references :card_bundle, null: false, foreign_key: true
      t.integer :transaction_type
      t.references :user, null: false, foreign_key: { to_table: :users }
      t.references :transferrer, null: true, foreign_key:  { to_table: :users }
      t.references :transferee, null: true, foreign_key:  { to_table: :users }
      t.integer :card_quantity
      t.string :description

      t.timestamps
    end
  end
end
