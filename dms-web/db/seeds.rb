# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

BarcodeSymbology.where(code: BarcodeSymbology::EAN_13).first_or_create!(name: "EAN 13")

User.where(email: "backoffice@company.com", mobile_number: "0820000001").
  first_or_create!(first_name: "Back", surname: "Office",
                   password: "password", password_confirmation: "password")
