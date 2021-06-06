# frozen_string_literal: true

class UserLoginsController < ApplicationController
  before_action :require_user, only: []

  def new
    @user_login = UserLogin.new
  end

  def create
    @user_login = UserLogin.new(user_login_params)

    unless @user_login.valid?
      render :new
      return
    end

    @user = @user_login.login
    if @user.nil?
      render :new
    else
      handle_successful_login(@user)
    end
  end

  def delete
    session[CurrentUser::SESSION_USER_KEY] = nil
    redirect_to "/login"
  end

  private
    def user_login_params
      params.require(:user_login).permit(:username, :password)
    end

    def handle_successful_login(user)
      create_session(user)
      redirect_to_return_rl
    end

    def create_session(user)
      session[CurrentUser::SESSION_USER_KEY] = user.id
    end

    def redirect_to_return_rl
      return_to_url = session[:return_to]

      if return_to_url.nil?
        redirect_to back_office_card_bundles_path
      else
        session[:return_to] = nil
        redirect_to return_to_url
      end
    end
end
