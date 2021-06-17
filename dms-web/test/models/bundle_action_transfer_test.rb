# frozen_string_literal: true

require "test_helper"
require_relative "./bundle_action_base"

class BundleActionTransferTest < BundleActionBase
  test "bundle action transfer" do
    bundle = bundles(:bundle_campaign_1_released_1)

    bundle_action = BundleAction.new_transfer_action(bundle)
    bundle_action.transferee_id = @user_agent_2.id
    bundle_action.execute!

    bundle.reload

    assert_equal 100, bundle.current_quantity
    assert_equal @user_agent_2.id, bundle.current_assignee_id

    assert_equal 1, bundle.transactions.count

    transaction = bundle.transactions.first
    assert_equal "transfer", transaction.transaction_type.to_s
    assert_equal 100, transaction.quantity
    assert_equal @user_agent_1.id, transaction.executed_by_id
    assert_equal @user_agent_1.id, transaction.logged_by_id
    assert_equal @user_agent_2.id, transaction.transferee_id
  end
end
