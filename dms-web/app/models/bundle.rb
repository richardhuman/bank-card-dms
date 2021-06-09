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
  before_create :load_bundle
  after_create :track_prepare_txn
  # before_save :check_for_transfer

  enum status: {
    empty: 1,
    loaded: 5,
    assigned: 10
  }, _suffix: "status"

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
      self.status = :loaded
      self.initial_quantity = current_quantity
    end

    def track_prepare_txn
      self.transactions.log_loaded!(user: current_user, quantity: self.current_quantity)
    end

  # def check_for_transfer
  #   if self.current_assignee_id_changed?
  #     self.transactions.log_transfer!(user: current_user,
  #                                     transferrer: User.find_by(id: self.current_assignee_id_was),
  #                                     transferee: User.find_by(id: self.current_assignee_id),
  #                                     current_quantity: self.current_quantity)
  #   end
  # end
end
