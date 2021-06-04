# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  validate :at_least_one_identifier

  private
    def at_least_one_identifier
      if self.mobile_number.blank? && self.email.blank?
        errors.add(:base, "At least one of mobile number or email must be completed.")
      end
    end
end
