# frozen_string_literal: true

class Campaign < ApplicationRecord
  include CurrentUser

  belongs_to :created_by, class_name: "User"
  has_many :bundle

  validates :title, presence: true, length: { maximum: 255 }
  validates :description, length: { maximum: 2000 }

  after_initialize :track_create_user

  scope :chronologically, -> () { order(created_at: :asc) }

  enum status: {
    open: 10,
    completed: 20
  }, _suffix: "status"

  def description_htmlize
    description.gsub("\n", "<br/>")
  end

  private
    def track_create_user
      self.created_by ||= current_user
    end
end
