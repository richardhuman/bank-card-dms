# frozen_string_literal: true

require "securerandom"
class UserInvitation < ApplicationRecord
  belongs_to :user

  DEFAULT_EXPIRY = 30.minutes

  class << self
    def create_invitation(user)
      invite = UserInvitation.new(user: user)
      invite.expires_at = Time.new + DEFAULT_EXPIRY
      invite.send(:generate_invitation_code)
      invite.save!
      invite
    end
  end

  def expired?
    Time.new > self.expires_at
  end

  def claimed?
    !self.claimed_at.nil?
  end

  def can_claim?
    !expired? && !claimed?
  end

  def claim!
    if claimed?
      raise ApplicationError.new(message: "Invitation already claimed at #{claimed_at.to_formatted_s(:timestamp)} by #{user.identifier}")
    end
    if expired?
      raise ApplicationError.new(message: "Invitation expired at #{expires_at.to_formatted_s(:timestamp)} ")
    end

    self.transaction do
      self.user.update!(activated_at: Time.new)
      self.update!(claimed_at: Time.new)
    end
  end

  def send_verification_email
    UserInvitationMailer.verify_email(user_invitation_id: self.id).deliver_later
  end

  private
    def generate_invitation_code
      self.invitation_code = SecureRandom.urlsafe_base64(32)
    end
end
