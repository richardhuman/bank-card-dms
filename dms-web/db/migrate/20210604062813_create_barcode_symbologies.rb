class CreateBarcodeSymbologies < ActiveRecord::Migration[6.1]
  def change
    create_table :barcode_symbologies do |t|
      t.string :code
      t.string :name

      t.timestamps
    end
    add_index :barcode_symbologies, :code, unique: true
    add_index :barcode_symbologies, :name, unique: true
  end
end
