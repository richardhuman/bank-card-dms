# frozen_string_literal: true

class User < ApplicationRecord
  belongs_to :manager, class_name: "User", optional: true
  has_many :managed_users, class_name: "User", foreign_key: :manager_id
  has_many :bundles, inverse_of: :current_assignee, foreign_key: :current_assignee_id
  has_many :user_invitations, dependent: :destroy

  has_secure_password

  validate :at_least_one_identifier
  # TODO: The email presence conflicts with the rule above, but we will be able
  # to remove it once once we can send invites to mobile numbers via SMS.
  validates :email, presence: true, uniqueness: true
  validates :mobile_number, uniqueness: true
  validates :manager, presence: true, if: proc { self.sales_agent_role? }

  scope :active, -> () { where.not(activated_at: nil) }
  scope :invited, -> () { where(activated_at: nil) }
  scope :managed_by, ->(user) { where(manager: user) }
  scope :primary_agent, -> () { includes(:manager).
                                    references(:manager).
                                    where("managers_users.user_role" => User.user_roles[:back_office]) }
  scope :order_name, -> () { order(first_name: :asc) }

  enum user_role: {
    back_office: 10,
    sales_agent: 20
  }, _suffix: "role"

  class << self
    def build_new_sales_agent_user(manager)
      user = User.new(user_role: :sales_agent, manager: manager)
      user.send(:generate_initial_password)
      user
    end
  end

  def activated?
    !activated_at.nil?
  end

  def can_be_destroyed?
    self.bundles.empty?
  end

  def full_name_with_identifier
    "#{first_name} #{surname} [#{identifier}]"
  end

  def full_name
    "#{first_name} #{surname}"
  end

  def default_name
    first_name # or full_name
  end

  def identifier
    !mobile_number.blank? ? mobile_number : email
  end

  private
    def at_least_one_identifier
      if self.mobile_number.blank? && self.email.blank?
        errors.add(:base, "At least one of mobile number or email must be completed.")
      end
    end

    def generate_initial_password
      self.password = SecureRandom.urlsafe_base64(32)
    end
end
