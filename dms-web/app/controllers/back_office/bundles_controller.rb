# frozen_string_literal: true

class BackOffice::BundlesController < BackOffice::BaseController
  before_action :set_bundle, only: [:edit, :update, :destroy, :transactions]
  before_action :load_supporting_models, except: [:index]

  def index
    @bundles = Bundle.active.chronologically
  end

  def new
    @bundle = Bundle.new
  end

  def edit; end

  def create
    @bundle = Bundle.new(bundle_params)

    if @bundle.save
      redirect_to url_for(action: :edit, id: @bundle), notice: I18n.t("forms.bundle.notices.create")
    else
      puts @bundle.errors
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @bundle.update(bundle_params)
      redirect_to url_for(action: :edit, id: @bundle), notice: I18n.t("forms.bundle.notices.update")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @bundle.handle_delete!
    redirect_to back_office_bundles_url, notice: I18n.t("forms.bundle.notices.delete")
  end

  private
    def set_bundle
      @bundle = Bundle.find(params[:id])
    end

    def bundle_params
      params.require(:bundle).permit(:bundle_number, :card_quantity, :current_assignee_id, :parent_bundle_id)
    end

    def load_supporting_models
      @available_parent_bundles = Bundle.empty.chronologically
      @agents = User.active.role_sales_agent
    end
end
