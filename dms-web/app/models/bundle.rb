# frozen_string_literal: true

class Bundle < ApplicationRecord
  include CurrentUser

  belongs_to :loaded_by, class_name: "User"
  belongs_to :campaign
  belongs_to :parent_bundle, class_name: "Bundle", optional: true, inverse_of: "child_bundles"
  belongs_to :current_assignee, class_name: "User", optional: true, inverse_of: "bundles"
  belongs_to :deleted_by, class_name: "User", optional: true

  has_many :child_bundles, class_name: "Bundle", foreign_key: :parent_bundle_id
  has_many :transactions, -> { order(created_at: :desc) }, class_name: "BundleTransaction"

  validates :bundle_number, uniqueness: { case_sensitive: false }, presence: true
  validates :current_assignee_id, presence: true, if: proc { self.released? }
  validates :current_quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validate :only_changes_on_actionable?

  scope :active, -> () { where(deleted_at: nil) }
  scope :assigned_to, -> (user) { where(current_assignee: user) }
  scope :chronologically, -> () { order(created_at: :asc) }
  scope :available_as_parent, -> () { loaded_status.or(released_status) }
  scope :stats_include_initial_quantity, -> () { not_creation_mode_split_transfer }

  after_initialize :track_loaded_user
  before_create :track_loaded
  before_save :track_released
  before_save :track_completion
  after_save -> () { campaign.touch }

  enum status: {
    empty: 1,
    loaded: 5,
    released: 10,
    completed: 15
  }, _suffix: "status"

  enum creation_mode: {
    loaded: 1,
    complete_transfer: 5,
    split_transfer: 10
  }, _prefix: "creation_mode"

  def handle_delete!
    self.deleted_at = Time.new
    self.deleted_by = current_user
    save!
  end

  def actionable?
    self.id.nil? || status.in?(%w[empty loaded released])
  end

  private
    def track_loaded_user
      self.loaded_by = current_user
    end

    def track_loaded
      self.initial_quantity = current_quantity
      unless self.released?
        self.status = :loaded
        self.transactions.build(transaction_type: :loaded,
                                quantity: self.current_quantity,
                                logged_by: current_user,
                                executed_by: self.loaded_by)
      end
    end

    def track_released
      if self.released_changed? && self.released?
        self.released_at = Time.new
        self.status = :released
        self.transactions.build(transaction_type: :released,
                                quantity: self.current_quantity,
                                logged_by: current_user,
                                executed_by: current_user,
                                transferee: current_assignee)
      end
    end

    def track_completion
      if self.current_quantity_changed? && self.current_quantity == 0 && !self.completed_status?
        self.status = :completed
        self.transactions.build(transaction_type: :completed,
                                quantity: 0,
                                logged_by: current_user,
                                executed_by: current_assignee)
      end
    end

    def only_changes_on_actionable?
      if (changed & %w[current_quantity current_assignee_id]).any? && !actionable?
        errors.add(:base, I18n.t("activerecord.errors.models.bundle.only_changes_on_actionable"))
      end
    end
end
