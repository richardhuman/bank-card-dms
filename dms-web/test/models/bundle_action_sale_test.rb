# frozen_string_literal: true

require "test_helper"
require_relative "./bundle_action_base"

class BundleActionSaleTest < BundleActionBase
  test "bundle action sale" do
    bundle = bundles(:bundle_campaign_1_released_1)
    assert bundle.valid?

    bundle_action = BundleAction.new_sale_action(bundle)
    bundle_action.quantity = 10
    bundle_action.execute!

    bundle.reload

    assert_equal 90, bundle.current_quantity
    assert_equal 100, bundle.initial_quantity

    assert_equal 1, bundle.transactions.count

    transaction = bundle.transactions.first
    assert_equal "sale", transaction.transaction_type.to_s
    assert_equal 10, transaction.quantity
    assert_equal @user_agent_1.id, transaction.executed_by_id
    assert_equal @user_agent_1.id, transaction.logged_by_id
  end

  test "bundle action sale validation fails on missing quantity" do
    bundle = bundles(:bundle_campaign_1_released_1)

    bundle_action = BundleAction.new_sale_action(bundle)
    bundle_action.quantity = nil
    assert_not bundle_action.valid?
    assert "can't be blank".in?(bundle_action.errors[:quantity])
    assert "is not a number".in?(bundle_action.errors[:quantity])
  end

  test "bundle action sale validation fails on quantity to great" do
    bundle = bundles(:bundle_campaign_1_released_1)

    bundle_action = BundleAction.new_sale_action(bundle)
    bundle_action.quantity = 200
    assert_not bundle_action.valid?
    puts bundle_action.errors[:base]
  end
end
