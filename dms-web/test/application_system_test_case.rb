# frozen_string_literal: true

require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :chrome, screen_size: [1400, 1400]

  Capybara.default_max_wait_time = 5

  private
    def login(username, password)
      visit root_url
      # check_at_login_page
      find("input[data-test-id='login-username']", visible: true).fill_in with: username
      find("input[data-test-id='login-password']", visible: true).fill_in with: password
      find("input[data-test-id='login-submit']").click
      find("a[data-test-id='navbar-link-current-user']", visible: true)
    end
end
