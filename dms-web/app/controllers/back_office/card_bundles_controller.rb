# frozen_string_literal: true

class BackOffice::CardBundlesController < BackOffice::BaseController
  before_action :set_card_bundle, only: [:edit, :update, :destroy]
  before_action :load_supporting_models, except: [:index]

  def index
    @card_bundles = CardBundle.active
  end

  def show
  end

  def new
    @card_bundle = CardBundle.new
  end

  def edit
  end

  def create
    @card_bundle = CardBundle.new(card_bundle_params)

    if @card_bundle.save
      redirect_to action: :index, notice: "Card bundle was successfully created."
    else
      render :new
    end
  end

  def update
    if @card_bundle.update(card_bundle_params)
      redirect_to action: :index, notice: "Card bundle was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @card_bundle.handle_delete!
    redirect_to back_office_card_bundles_url, notice: "Card bundle was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card_bundle
      @card_bundle = CardBundle.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def card_bundle_params
      params.require(:card_bundle).permit(:bundle_number, :card_quantity, :current_assignee_id)
    end

    def load_supporting_models
      @available_parent_bundles = CardBundle.empty
      @agents = User.active.role_sales_agent
    end
end
