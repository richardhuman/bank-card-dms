# frozen_string_literal: true

class ApplicationError < StandardError
  attr_accessor :message, :user

  def initialize(user: nil, message:)
    @user = user
    @message = "Application error: #{message} #{ "(user: #{@user.identifier}" unless @user.nil?}"
  end

  def to_s
    @message
  end
end
