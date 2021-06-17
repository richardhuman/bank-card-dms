# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# BarcodeSymbology.where(code: BarcodeSymbology::EAN_13).first_or_create!(name: "EAN 13")

back_office = User.where(email: "maria@company.com", mobile_number: "0820000001").
  first_or_create!(first_name: "Maria", surname: "Garcia",
                   password: "password", password_confirmation: "password",
                   user_role: :back_office, activated_at: Time.new)

helen = User.where(email: "helen@sales.com", mobile_number: "0720000002").
  first_or_create!(first_name: "Helen", surname: "Smith",
                   password: "password", password_confirmation: "password",
                   user_role: :sales_agent, manager: back_office, activated_at: Time.new)

lisa = User.where(email: "lisa@sales.com", mobile_number: "0620000003").
  first_or_create!(first_name: "Lisa", surname: "Johnson",
                   password: "password", password_confirmation: "password",
                   user_role: :sales_agent, manager: back_office, activated_at: Time.new)

User.where(email: "sally@sales.com", mobile_number: "0720000004").
  first_or_create!(first_name: "Sally", surname: "Brown",
                   password: "password", password_confirmation: "password",
                   user_role: :sales_agent, manager: helen, activated_at: Time.new)

Campaign.where(title: "New bank card launch - 2020").
  first_or_create!(description: "Launch of new bank card product in Mar 2020 - 15000 cards",
                   status: :completed,
                   created_by: back_office)

Campaign.where(title: "Red Card Launch - Jan 2021").
  first_or_create!(description: "New Red Card launch",
                   status: :open,
                   created_by: back_office)

Campaign.where(title: "Blue Card Launch - Feb 2021").
  first_or_create!(description: "New Blue Card launch",
                   status: :open,
                   created_by: back_office)
