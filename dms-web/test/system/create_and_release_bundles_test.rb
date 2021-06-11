# frozen_string_literal: true

require "application_system_test_case"

class CreateAndReleaseBundlesTest < ApplicationSystemTestCase
  # include ::LoginHelper

  def setup
    @username = "0820000001"
    @password = "password"
    @user = User.find_by(mobile_number: @username)
  end

  def teardown
    # take_failed_screenshot
    take_screenshot
  end

  def test_create_bundle
    login(@user.mobile_number, @password)
    find("a[data-test-id='navbar-link-current-user']", visible: true)
    # assert_equal @user.first_name.upcase, f.value
  end


  def login(username, password)
    visit root_url
    # check_at_login_page
    find("input[data-test-id='login-username']", visible: true).fill_in with: username
    find("input[data-test-id='login-password']", visible: true).fill_in with: password
    find("input[data-test-id='login-submit']").click
  end

  # private
  #   def check_at_login_page
  #     assert_text "DMS"
  #     assert find("input[data-test-id='login-username']", visible: true)
  #     assert find("input[data-test-id='login-password']", visible: true)
  #     assert find("input[data-test-id='login-submit']")
  #   end
end
