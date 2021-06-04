# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  validate :at_least_one_identifier

  scope :active, ->() { where(deleted_at: nil) }

  def full_name_with_identifier
    "#{first_name} #{surname} [#{identifier}]"
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
