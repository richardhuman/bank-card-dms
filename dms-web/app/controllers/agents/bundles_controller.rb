# frozen_string_literal: true

class Agents::BundlesController < Agents::BaseController
  before_action :set_bundle, except: [:index]
  before_action :set_lookups, except: [:index]

  def index
    @my_bundles = Bundle.active.released_status.assigned_to(current_user).chronologically
  end

  def edit
    @bundle = Bundle.find(params[:id])
  end

  private
    def set_bundle
      @bundle = Bundle.find(params[:id])
    end

    def set_lookups
      @sub_agents = current_user.sub_agents.active.sales_agent_role.order_name
    end
end
