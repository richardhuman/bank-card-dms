# frozen_string_literal: true

class CardBundleTransaction < ApplicationRecord
  belongs_to :card_bundle
  belongs_to :src, class_name: "User"
  belongs_to :dest, class_name: "User"

  enum transaction_type: {
    loaded: 1,
    transfer: 2,
    sale: 3,
    return: 4
  }
end
