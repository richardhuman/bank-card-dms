# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# BarcodeSymbology.where(code: BarcodeSymbology::EAN_13).first_or_create!(name: "EAN 13")

back_office = User.where(email: "backoffice@company.com", mobile_number: "0820000001").
  first_or_create!(first_name: "Richard", surname: "BackOffice",
                   password: "password", password_confirmation: "password",
                   user_role: :back_office, activated_at: Time.new)

jimmy = User.where(email: "jimmy@company.com", mobile_number: "0820000002").
  first_or_create!(first_name: "Jimmy", surname: "SalesAgent",
                   password: "password", password_confirmation: "password",
                   user_role: :sales_agent, manager: back_office, activated_at: Time.new)

robert = User.where(email: "robert@company.com", mobile_number: "0820000003").
  first_or_create!(first_name: "Robert", surname: "SalesAgent",
                   password: "password", password_confirmation: "password",
                   user_role: :sales_agent, manager: back_office, activated_at: Time.new)

User.where(email: "sally@company.com", mobile_number: "0820000004").
  first_or_create!(first_name: "Sally", surname: "SalesAgent",
                   password: "password", password_confirmation: "password",
                   user_role: :sales_agent, manager: jimmy, activated_at: Time.new)

Campaign.create!(title: "New bank card launch - 2020",
                 description: "Launch of new bank card product in Mar 2020 - 15000 cards",
                 status: :completed,
                 created_by: back_office)

Campaign.create!(title: "Red Card Launch - Jan 2021",
                 description: "New Red Card launch",
                 status: :open,
                 created_by: back_office)

Campaign.create!(title: "Blue Card Launch - Feb 2021",
                 description: "New Blue Card launch",
                 status: :open,
                 created_by: back_office)
