# frozen_string_literal: true

class User < ApplicationRecord
  belongs_to :manager, class_name: "User", optional: true

  has_secure_password

  validate :at_least_one_identifier
  validates :manager, presence: true, if: proc { self.sales_agent_role? }

  scope :active, -> () { where(deleted_at: nil) }
  scope :order_name, -> () { order(first_name: :asc) }
  scope :managed_by, -> (user) { where(manager: user) }

  enum user_role: {
    super_user: 1,
    back_office: 10,
    sales_agent: 20
  }, _suffix: "role"

  def active?
    deleted_at.nil?
  end

  def full_name_with_identifier
    "#{first_name} #{surname} [#{identifier}]"
  end

  def full_name
    "#{first_name} #{surname}"
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
end
