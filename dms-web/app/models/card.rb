# frozen_string_literal: true

# Currently unused in phase 1
class Card < ApplicationRecord
  belongs_to :bundle

  enum status: {
    unallocated: 1,
    sold: 10
  }
end
