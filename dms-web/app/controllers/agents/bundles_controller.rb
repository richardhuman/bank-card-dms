# frozen_string_literal: true

class Agents::BundlesController < Agents::BaseController
  before_action :set_bundle, except: [:index]
  before_action :set_lookups, except: [:index]

  def index
    @my_bundles = Bundle.active.released_status.assigned_to(current_user).chronologically
  end

  def edit
    @bundle_sale_action = BundleAction.new_sale_action(@bundle)
    @bundle_transfer_action = BundleAction.new_transfer_action(@bundle)
  end

  def update
    bundle_action = BundleAction.new(bundle_action_params)
    bundle_action.bundle = @bundle
    if bundle_action.valid?
      bundle_action.execute!
      if @bundle.actionable?
        redirect_to url_for(action: :edit, id: @bundle), notice: t("forms.bundle_action.notices.sale", quantity: bundle_action.quantity, name: bundle_action.transferee_name)
      else
        redirect_to url_for(action: :index),
                    notice: [
                      t("forms.bundle_action.notices.sale", quantity: bundle_action.quantity, name: bundle_action.transferee_name),
                      t("forms.bundle.notices.actionable")
                    ].join("<br/>")
      end
    else
      @bundle_sale_action = bundle_action if bundle_action.sale_action?
      @bundle_transfer_action = bundle_action if bundle_action.transfer_action?
      render :edit, id: @bundle.id, status: :unprocessable_entity
    end
  end

  private
    def set_bundle
      @bundle = Bundle.find(params[:id])
    end

    def bundle_action_params
      params.require(:bundle_action).permit(:quantity, :transferee_id, :action)
    end

    def set_lookups
      @sub_agents = current_user.sub_agents.active.sales_agent_role.order_name
    end
end
