# frozen_string_literal: true

require "application_system_test_case"

class CreateAndReleaseBundlesTest < ApplicationSystemTestCase
  def setup
    @password = "password"
    @back_office_user = users(:back_office_user)
    @agent_agent = users(:sales_agent_1_1)
    @campaign = campaigns(:campaign_launch)
  end

  def teardown
    # take_failed_screenshot
    # take_screenshot
  end

  test "create bundle" do
    login(@back_office_user.mobile_number, @password)
    find(".navbar a[data-test-id='back-office-navbar-bundles']").click
    find("#turbo-main-content-frame a[data-test-id='back-office-bundles-add']").click


    # TODO: Capybara not finding the injected turbo-frame
    find("#turbo-main-content-frame select[data-test-id='bundle-edit-bundle-number']").fill_in with: "100.1"
    find("#turbo-main-content-frame select[data-test-id='bundle-edit-current-quantity']").fill_in with: "100"
    find("#turbo-main-content-frame select[data-test-id='bundle-edit-current-assignee']").select @agent_agent.full_name_with_identifier
    find("#turbo-main-content-frame select[data-test-id='bundle-edit-campaign']").select @campaign.id.to_s
    find("#turbo-main-content-frame select[data-test-id='bundle-released']").check
    find("#turbo-main-content-frame select[data-test-id='bundle-edit-submit']").click

    expect(find("#notice")).to have_content("The bundle was successfully created.")

    all("#turbo-main-content-frame #card-bundle-transactions table tbody tr").length
  end
end
