# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Authentication

  helper_method :current_user
  helper_method :sub_layout

  protect_from_forgery with: :exception

  def sub_layout
    "default"
  end
end
