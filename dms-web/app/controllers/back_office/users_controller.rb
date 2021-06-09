# frozen_string_literal: true

class BackOffice::UsersController < BackOffice::BaseController
  def index
    @users = User.active.order_name
  end
end