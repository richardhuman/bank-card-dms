# frozen_string_literal: true

class UserSessionsController < ApplicationController
  before_action :authenticate, only: []

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(user_login_params)

    unless @user_session.valid?
      render :new
      return
    end

    @user = @user_session.login
    if @user.nil?
      render :new, status: :unprocessable_entity
    else
      handle_successful_login(@user)
    end
  end

  def delete
    delete_session
    redirect_to "/login"
  end

  private
    def user_login_params
      params.require(:user_session).permit(:username, :password)
    end

    def handle_successful_login(user)
      create_session(user)
      redirect_to_return_url(user)
    end

    def redirect_to_return_url(user)
      return_to_url = get_unauthenticated_location

      if return_to_url.nil?
        redirect_to get_home_path_for_user(user)
      else
        clear_unauthenticated_location
        redirect_to return_to_url
      end
    end

    def get_home_path_for_user(user)
      if user.back_office_role? || user.super_user_role?
        back_office_bundles_path
      else
        raise "Not supported yet"
      end
    end
end
