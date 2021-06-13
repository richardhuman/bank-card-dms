# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: Rails.configuration.tenant["email_default_from"]
  layout "mailer"
end
