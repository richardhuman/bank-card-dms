# frozen_string_literal: true

class CreateBarcodeSymbologies < ActiveRecord::Migration[6.1]
  def change
    create_table :barcode_symbologies do |t|
      t.string :code, null: false
      t.string :name, null: false

      t.timestamps
    end
    add_index :barcode_symbologies, :code, unique: true
    add_index :barcode_symbologies, :name, unique: true
  end
end
