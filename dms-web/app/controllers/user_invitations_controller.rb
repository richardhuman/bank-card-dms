# frozen_string_literal: true

class UserInvitationsController < ApplicationController
  before_action :authenticate, except: [:claim]
  def claim
    delete_session
    invite = UserInvitation.find_by(invitation_code: params[:invitation_code])

    if invite.nil?
      redirect_to new_user_session_path, alert: t("user_invitations.errors.expired")
      return
    end
    redirect_to new_user_session_path, alert: t("user_invitations.errors.expired") if invite.expired?
    redirect_to new_user_session_path, alert: t("user_invitations.errors.claimed", username: invite.user.identifier) if invite.claimed?

    if invite.can_claim?
      invite.claim!
      create_session(invite.user)
      redirect_to edit_agents_user_path(invite.user), notice: t("user_invitations.actions.claimed")
    end
  end
end
