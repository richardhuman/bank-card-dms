require "test_helper"

class BackOffice::BundlesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get back_office_bundles_index_url
    assert_response :success
  end

  test "should get new" do
    get back_office_bundles_new_url
    assert_response :success
  end

  test "should get create" do
    get back_office_bundles_create_url
    assert_response :success
  end

  test "should get edit" do
    get back_office_bundles_edit_url
    assert_response :success
  end

  test "should get update" do
    get back_office_bundles_update_url
    assert_response :success
  end
end
