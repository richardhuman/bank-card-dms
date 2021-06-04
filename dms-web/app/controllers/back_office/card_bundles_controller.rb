# frozen_string_literal: true

class BackOffice::CardBundlesController < ApplicationController
  before_action :set_card_bundle, only: [:show, :edit, :update, :destroy]

  # GET /card_bundlees
  def index
    @card_bundles = CardBundle.all
  end

  # GET /card_bundlees/1
  def show
  end

  # GET /card_bundlees/new
  def new
    load_supporting_models
    @card_bundle = CardBundle.new
  end

  # GET /card_bundlees/1/edit
  def edit
    load_supporting_models
  end

  # POST /card_bundlees
  def create
    @card_bundle = CardBundle.new(card_bundle_params)

    if @card_bundle.save
      redirect_to [:back_office, @card_bundle], notice: "card_bundle was successfully created."
    else
      load_supporting_models
      render :new
    end
  end

  # PATCH/PUT /card_bundlees/1
  def update
    if @card_bundle.update(card_bundle_params)
      redirect_to [:back_office, @card_bundle], notice: "card_bundle was successfully updated."
    else
      load_supporting_models
      render :edit
    end
  end

  # DELETE /card_bundlees/1
  def destroy
    @card_bundle.destroy
    redirect_to back_office_card_bundles_url, notice: "card_bundle was successfully destroyed."
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
      @agents = User.active
    end
end
