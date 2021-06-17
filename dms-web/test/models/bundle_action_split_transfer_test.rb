# frozen_string_literal: true

require "test_helper"
require_relative "./bundle_action_base"

class BundleSplitTransferTest < BundleActionBase
  test "bundle action split transfer with remaining quantities" do
    original_bundle = bundles(:bundle_campaign_1_released_1)

    bundle_action = BundleAction.new_split_transfer_action(original_bundle)
    bundle_action.quantity = 40
    bundle_action.transferee_id = @user_agent_2.id
    bundle_action.execute!

    original_bundle.reload
    new_bundle = Bundle.find_by(bundle_number: "#{original_bundle.bundle_number}-1")

    # Original bundle
    assert_equal 100, original_bundle.initial_quantity
    assert_equal 60, original_bundle.current_quantity
    assert_equal @user_agent_1.id, original_bundle.current_assignee_id

    # Original bundle transactions
    assert_equal 1, original_bundle.transactions.count
    transaction = original_bundle.transactions.first
    assert_equal "transfer", transaction.transaction_type.to_s
    assert_equal 40, transaction.quantity
    assert_equal @user_agent_1.id, transaction.executed_by_id
    assert_equal @user_agent_1.id, transaction.logged_by_id
    assert_equal @user_agent_2.id, transaction.transferee_id

    # New bundle
    assert_equal original_bundle.id, new_bundle.parent_bundle_id
    assert_equal 40, new_bundle.initial_quantity
    assert_equal 40, new_bundle.current_quantity
    assert new_bundle.released?
    assert_equal @user_agent_1.id, new_bundle.loaded_by_id
    assert_equal @user_agent_2.id, new_bundle.current_assignee_id
    assert_equal "split_transfer", new_bundle.creation_mode.to_s

    # New bundle transactions
    assert_equal 1, original_bundle.transactions.count

    transaction = original_bundle.transactions.first
    assert_equal "transfer", transaction.transaction_type.to_s
    assert_equal 40, transaction.quantity
    assert_equal @user_agent_1.id, transaction.executed_by_id
    assert_equal @user_agent_1.id, transaction.logged_by_id
    assert_equal @user_agent_2.id, transaction.transferee_id
  end
end
