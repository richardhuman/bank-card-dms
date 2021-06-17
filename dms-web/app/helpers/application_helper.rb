# frozen_string_literal: true

module ApplicationHelper
  def get_application_name
    # TODO: Investigate why during system tests Rails.configuration.tenant is not available here.
    return "Test DMS application name" if Rails.env.test?
    Rails.configuration.tenant["application_name"]
  end

  def get_main_turbo_frame
    "turbo-main-content-frame"
  end

  def nb(html)
    return html if html.blank?
    raw(html.gsub("-", "&#8209;").gsub(" ", "&nbsp;"))
  end
end
