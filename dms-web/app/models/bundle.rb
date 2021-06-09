# frozen_string_literal: true

class Bundle < ApplicationRecord
  include CurrentUser

  belongs_to :loaded_by, class_name: "User"
  belongs_to :parent_bundle, class_name: "Bundle", optional: true
  belongs_to :current_assignee, class_name: "User", optional: true
  belongs_to :deleted_by, class_name: "User", optional: true

  has_many :transactions, -> { order(created_at: :desc) }, class_name: "BundleTransaction"

  validates :bundle_number, uniqueness: { case_sensitive: false }, presence: true
  validates :current_assignee_id, presence: true, if: proc { self.released? }
  validates :current_quantity, presence: true, numericality: { only_integer: true }

  scope :active, -> () { where(deleted_at: nil) }
  scope :assigned_to, -> (user) { where(current_assignee: user) }
  scope :chronologically, -> () { order(created_at: :asc) }

  after_initialize :track_loaded_user
  before_save :track_released
  before_create :track_loaded

  # before_create :load_bundle
  # after_create :track_prepare_txn
  # before_save :check_for_transfer

  enum status: {
    empty: 1,
    loaded: 5,
    released: 10
  }, _suffix: "status"

  def handle_delete!
    self.deleted_at = Time.new
    self.deleted_by = current_user
    save!
  end

  def transfer_quantity=(t)
  end

  def transfer_quantity
  end

  def new_assignee_id=(t)
  end

  def new_assignee_id
  end

  private
    def track_loaded_user
      self.loaded_by = current_user
    end

    def track_loaded
      unless self.released?
        self.status = :loaded
      end
      self.initial_quantity = current_quantity
      self.transactions.build(transaction_type: :loaded,
                              quantity: self.current_quantity,
                              user: current_user)
    end

    def track_released
      if self.released_changed? && self.released?
        self.released_at = Time.new
        self.status = :released
        self.transactions.build(transaction_type: :released,
                                quantity: self.current_quantity,
                                user: current_user,
                                transferee: current_assignee)
      end
    end

  # def track_prepare_txn
  #   self.transactions.log_loaded!(user: current_user, quantity: self.current_quantity)
  # end

  # def check_for_transfer
  #   if self.current_assignee_id_changed?
  #     self.transactions.log_transfer!(user: current_user,
  #                                     transferrer: User.find_by(id: self.current_assignee_id_was),
  #                                     transferee: User.find_by(id: self.current_assignee_id),
  #                                     current_quantity: self.current_quantity)
  #   end
  # end
end
