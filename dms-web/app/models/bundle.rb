# frozen_string_literal: true

class Bundle < ApplicationRecord
  include CurrentUser

  belongs_to :parent_bundle, class_name: "Bundle", optional: true
  belongs_to :current_assignee, class_name: "User", optional: true
  belongs_to :loaded_by, class_name: "User"
  belongs_to :deleted_by, class_name: "User", optional: true

  has_many :transactions, -> { order(created_at: :desc) }, class_name: "BundleTransaction"

  validates :bundle_number, uniqueness: { case_sensitive: false }, presence: true

  scope :active, -> () { where(deleted_at: nil) }
  scope :assigned_to, -> (user) { where(current_assignee: user) }
  scope :chronologically, -> () { order(created_at: :asc) }

  after_initialize :track_create_user
  after_create :load_bundle
  before_save :check_for_transfer

  enum status: {
    empty: 1,
    prepared: 5,
    assigned: 10
  }

  def handle_delete!
    self.deleted_at = Time.new
    self.deleted_by = current_user
    save!
  end

  private
    def track_create_user
      self.loaded_by = current_user
    end

    def load_bundle
      self.prepared!
      self.transactions.log_prepare!(user: current_user, card_quantity: self.card_quantity)
    end

    def check_for_transfer
      if self.current_assignee_id_changed?
        self.transactions.log_transfer!(user: current_user,
                                        transferrer: User.find_by(id: self.current_assignee_id_was),
                                        transferee: User.find_by(id: self.current_assignee_id),
                                        card_quantity: self.card_quantity)
      end
    end
end
