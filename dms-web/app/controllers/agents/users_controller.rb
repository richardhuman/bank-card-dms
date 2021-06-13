# frozen_string_literal: true

class Agents::UsersController < Agents::BaseController
  before_action :set_user, only: [:edit, :update, :destroy]

  def index
    @my_users = current_user.managed_users.order_name
  end

  def new
    @user = User.build_new_sales_agent_user(current_user)
  end

  def create
    @user = User.build_new_sales_agent_user(current_user)
    @user.attributes = user_params
    if @user.valid?
      handle_create_new_user(@user)
      # redirect_to url_for(action: :edit, id: @user), notice: I18n.t("forms.user.notices.create")
      redirect_to agents_users_path, notice: I18n.t("forms.user.notices.create")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to url_for(action: :edit, id: @user), notice: I18n.t("forms.user.notices.update")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @user.can_be_destroyed?
      @user.destroy
      redirect_to agents_users_path, notice: I18n.t("forms.user.notices.delete")
    else
      redirect_to agents_users_path, alert: I18n.t("forms.user.notices.unable_to_delete")
    end
  end

  private
    def set_user
      @user = User.managed_by(current_user).find(params[:id])
    end

    def user_params
      params.require(:user).permit(:first_name, :surname, :email, :mobile_number, :password, :password_confirmation)
    end

    def handle_create_new_user(user)
      invite = nil
      ApplicationRecord.transaction do
        user.save!
        invite = UserInvitation.create_invitation(user)
      end
      invite.send_verification_email
    end
end
