# frozen_string_literal: true

module LoginHelper
  def login(user, password)
    visit root_url
    check_at_login_page
    find("input[data-test-object-id='input_Username']", visible: true).fill_in with: user
    find("input[data-test-object-id='input_Password']", visible: true).fill_in with: password
    find("input[data-test-object-id='input_LoginButton']").click
  end

  private
    def check_at_login_page
      assert_text "DMS"
      assert find("input[data-test-id='login-username']", visible: true)
      assert find("input[data-test-id='login-password']", visible: true)
      assert find("input[data-test-id='login-submit']")
    end
end
