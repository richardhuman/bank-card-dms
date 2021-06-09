# frozen_string_literal: true

class BundleTransaction < ApplicationRecord
  belongs_to :bundle
  belongs_to :user
  belongs_to :transferrer, class_name: "User", optional: true
  belongs_to :transferee, class_name: "User", optional: true

  scope :chronologically, ->() { order(created_at: :asc) }
  scope :reverse_chronologically, ->() { order(created_at: :desc) }

  enum transaction_type: {
    loaded: 1,
    released: 5,
    transfer: 10,
    sale: 15,
    return: 20
  }, _suffix: "txn"

  # def self.log_loaded(user:, quantity:, description: nil)
  #   build(user: user, transaction_type: :loaded, quantity: quantity, description: description)
  # end
  #
  # def self.log_released(user:, quantity:, description: nil)
  #   build(user: user, transaction_type: :assigned, quantity: quantity, description: description)
  # end

  # def self.log_transfer!(user:, transferrer:, transferee:, current_quantity:, description: nil)
  #   create!(user: user, transaction_type: :transfer,
  #           transferrer: transferrer, transferee: transferee,
  #           current_quantity: current_quantity, description: description)
  # end
end
