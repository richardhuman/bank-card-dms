# frozen_string_literal: true

class UserInvitationMailer < ApplicationMailer
  def verify_email(user_invitation_id:)
    @user_invitation = UserInvitation.find(user_invitation_id)
    mail to: @user_invitation.user.email,
         subject: "[Placeholder: verification email subject]" do |format|
      format.html { render :verify_email }
    end
  end
end
