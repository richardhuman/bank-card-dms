# frozen_string_literal: true

class BackOffice::CardBundlesController < BackOffice::BaseController
  before_action :set_card_bundle, only: [:edit, :update, :destroy, :transactions]
  before_action :load_supporting_models, except: [:index]

  def index
    @card_bundles = CardBundle.active.chronologically
  end

  def new
    @card_bundle = CardBundle.new
  end

  def edit; end

  def create
    @card_bundle = CardBundle.new(card_bundle_params)

    if @card_bundle.save
      redirect_to url_for(action: :edit, id: @card_bundle), notice: I18n.t("forms.card_bundle.notices.create")
    else
      render :new
    end
  end

  def update
    if @card_bundle.update(card_bundle_params)
      redirect_to url_for(action: :edit, id: @card_bundle), notice: I18n.t("forms.card_bundle.notices.update")
    else
      render :edit
    end
  end

  def destroy
    @card_bundle.handle_delete!
    redirect_to back_office_card_bundles_url, notice: I18n.t("forms.card_bundle.notices.delete")
  end

  private
    def set_card_bundle
      @card_bundle = CardBundle.find(params[:id])
    end

    def card_bundle_params
      params.require(:card_bundle).permit(:bundle_number, :card_quantity, :current_assignee_id)
    end

    def load_supporting_models
      @available_parent_bundles = CardBundle.empty.chronologically
      @agents = User.active.role_sales_agent
    end
end
