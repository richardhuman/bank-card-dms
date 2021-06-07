# frozen_string_literal: true

class CardBundleTransaction < ApplicationRecord
  belongs_to :card_bundle
  belongs_to :user
  belongs_to :transferrer, class_name: "User", optional: true
  belongs_to :transferee, class_name: "User", optional: true

  enum transaction_type: {
    prepared: 1,
    transfer: 2,
    sale: 3,
    return: 4
  }

  def self.log_prepare!(user:, card_quantity:, description: nil)
    create!(user: user, transaction_type: :prepared, card_quantity: card_quantity, description: description)
  end

  def self.log_transfer!(user:, transferrer:, transferee:, card_quantity:, description: nil)
    create!(user: user, transaction_type: :transfer,
            transferrer: transferrer, transferee: transferee,
            card_quantity: card_quantity, description: description)
  end
end
