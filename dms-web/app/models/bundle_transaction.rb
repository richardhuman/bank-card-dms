# frozen_string_literal: true

class BundleTransaction < ApplicationRecord
  belongs_to :bundle
  belongs_to :logged_by, class_name: "User"
  belongs_to :executed_by, class_name: "User"
  belongs_to :transferee, class_name: "User", optional: true

  scope :chronologically, ->() { order(created_at: :asc) }
  scope :reverse_chronologically, ->() { order(created_at: :desc) }

  enum transaction_type: {
    loaded: 1,
    released: 5,
    transfer: 10,
    sale: 15,
    return: 20,
    completed: 25
  }, _suffix: "txn"

end
