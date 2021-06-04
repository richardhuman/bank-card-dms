# frozen_string_literal: true

class Card < ApplicationRecord
  belongs_to :bundle, class_name: "CardBundle"

  enum status: {
    new: 1,
    sold: 10
  }
end
