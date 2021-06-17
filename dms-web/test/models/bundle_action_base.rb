# frozen_string_literal: true

require "test_helper"

class BundleActionBase < ActiveSupport::TestCase
  def setup
    @user_agent_1 = users(:sales_agent_1_1)
    @user_agent_2 = users(:sales_agent_1_2)
    CurrentRequest.user_id = @user_agent_1.id
  end

  def teardown
    CurrentRequest.reset
  end
end
