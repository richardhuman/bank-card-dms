# frozen_string_literal: true

module ApplicationHelper
  def get_application_name
    "Band-Card DMS"
  end

  def get_main_turbo_frame
    "turbo-main-content-frame"
  end

  def nb(html)
    return html if html.blank?
    raw(html.gsub("-", "&#8209;").gsub(" ", "&nbsp;"))
  end
end
