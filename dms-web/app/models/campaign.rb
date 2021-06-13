# frozen_string_literal: true

class Campaign < ApplicationRecord
  include CurrentUser

  belongs_to :created_by, class_name: "User"
  has_many :bundles

  validates :title, presence: true, length: { maximum: 255 }
  validates :description, length: { maximum: 2000 }

  before_create :track_create_user

  scope :chronologically, -> () { order(created_at: :asc) }

  after_update_commit -> { broadcast_replace_later_to self, partial: "back_office/dashboard/campaign_stat_row" }

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
