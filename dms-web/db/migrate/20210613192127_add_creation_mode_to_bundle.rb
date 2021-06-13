class AddCreationModeToBundle < ActiveRecord::Migration[6.1]
  def change
    add_column :bundles, :creation_mode, :integer, default: 1, null: false
  end
end
