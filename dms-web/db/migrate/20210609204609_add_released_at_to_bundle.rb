# frozen_string_literal: true

class AddReleasedAtToBundle < ActiveRecord::Migration[6.1]
  def change
    add_column :bundles, :released_at, :timestamp
    add_column :bundles, :released, :boolean, null: false, default: false
  end
end
