# frozen_string_literal: true

class BundleAction
  include ActiveModel::Model
  include CurrentUser

  attr_accessor :bundle, :action, :quantity, :transferee_id

  ACTIONS = [:sale, :transfer, :split_transfer]

  validates :action, inclusion: ACTIONS.collect(&:to_s), presence: true
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, if: proc { self.sale_action? || self.split_transfer_action? }
  validates :transferee_id, presence: true, if: proc { self.transfer_action? || self.split_transfer_action? }
  validate :check_quantity_against_bundle, if: proc { self.sale_action? || self.split_transfer_action? }

  class << self
    def new_sale_action(bundle)
      BundleAction.new(action: :sale, bundle: bundle)
    end

    def new_transfer_action(bundle)
      BundleAction.new(action: :transfer, bundle: bundle)
    end

    def new_split_transfer_action(bundle)
      BundleAction.new(action: :split_transfer, bundle: bundle)
    end
  end

  def execute!
    if sale_action?
      handle_sale!
    elsif split_transfer_action?
      handle_split_transfer!
    elsif transfer_action?
      handle_transfer!
    else
      raise ApplicationError.new(message: "Unknown bundle action: #{action} for bundle #{bundle.id}", user: current_user)
    end
  end

  def transferee_name
    User.find_by(id: transferee_id)&.default_name
  end

  def sale_action?
    self.action.to_sym == :sale
  end

  def transfer_action?
    self.action.to_sym == :transfer
  end

  def split_transfer_action?
    self.action.to_sym == :split_transfer
  end

  private

    def check_quantity_against_bundle
      if self.quantity.to_i > self.bundle.current_quantity.to_i
        errors.add(:sale_quantity, I18n.t("activemodel.errors.models.bundle_action.invalid_sale_quantity"))
      end
    end

    def handle_sale!
      self.bundle.current_quantity -= self.quantity.to_i
      self.bundle.transactions.build(transaction_type: :sale,
                                     logged_by: current_user,
                                     executed_by: bundle.current_assignee,
                                     quantity: self.quantity.to_i)
      self.bundle.save!
    end

    def handle_transfer!
      ApplicationRecord.transaction do
        self.bundle.transactions.create!(transaction_type: :transfer,
                                         logged_by: current_user,
                                         executed_by: bundle.current_assignee,
                                         transferee_id: self.transferee_id,
                                         quantity: self.bundle.current_quantity,
                                         description: ["Complete transfer of bundle #{self.bundle.bundle_number}",
                                                      "to new #{User.find(self.transferee_id).default_name}",
                                                      "(ID: #{self.transferee_id})"].join(" "))

        self.bundle.current_assignee_id = self.transferee_id
        self.bundle.save!
      end
    end

    def handle_split_transfer!
      ApplicationRecord.transaction do
        self.bundle.current_quantity -= self.quantity.to_i
        self.bundle.save!

        new_bundle_transfer_index = self.bundle.child_bundles.count + 1
        new_bundle = Bundle.create!(parent_bundle_id: self.bundle.id,
                                    campaign_id: self.bundle.campaign_id,
                                    bundle_number: "#{self.bundle.bundle_number}-#{new_bundle_transfer_index}",
                                    current_quantity: self.quantity.to_i,
                                    current_assignee_id: self.transferee_id,
                                    loaded_by: self.current_user,
                                    creation_mode: :split_transfer,
                                    released: true)

        self.bundle.transactions.create!(transaction_type: :transfer,
                                         logged_by: current_user,
                                         executed_by: bundle.current_assignee,
                                         transferee_id: self.transferee_id,
                                         quantity: self.quantity.to_i,
                                         description: ["Transfer of #{self.quantity} units",
                                                       "from bundle #{self.bundle.bundle_number}",
                                                       " to new bundle #{new_bundle.bundle_number}"].join(" "))

        new_bundle.transactions.create!(transaction_type: :transfer,
                                        logged_by: current_user,
                                        executed_by: bundle.current_assignee,
                                        transferee_id: self.transferee_id,
                                        quantity: self.quantity.to_i,
                                        description: ["Transfer of #{self.quantity} units",
                                                      "from bundle #{self.bundle.bundle_number}",
                                                      "to new bundle #{new_bundle.bundle_number}"].join(" "))
      end
    end
end
