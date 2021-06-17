class RemoveDeletedAtFromBundle < ActiveRecord::Migration[6.1]
  def change
    remove_column :bundles, :deleted_at
    remove_column :bundles, :deleted_by_id
  end
end
