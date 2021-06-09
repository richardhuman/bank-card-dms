# frozen_string_literal: true

class AddDeleteFlagsToBundle < ActiveRecord::Migration[6.1]
  def change
    add_column :bundles, :deleted_at, :timestamp, null: true
    add_reference :bundles, :deleted_by, null: true, foreign_key: { to_table: :users }
  end
end
