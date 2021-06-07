# frozen_string_literal: true

class BackOffice::CampaignsController < ApplicationController
  before_action :set_campaign, only: [:show, :edit, :update, :destroy]

  def index
    @campaigns = Campaign.all
  end

  def new
    @campaign = Campaign.new
  end

  def edit
  end

  def create
    @campaign = Campaign.new(campaign_params)

    if @campaign.save
      redirect_to url_for(action: :edit, id: @campaign), notice: "Campaign was successfully created."
    else
      render :new
    end
  end

  def update
    if @campaign.update(campaign_params)
      redirect_to url_for(action: :edit, id: @campaign), notice: "Campaign was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @campaign.destroy
    redirect_to campaigns_url, notice: "Campaign was successfully destroyed."
  end

  private
    def set_campaign
      @campaign = Campaign.find(params[:id])
    end

    def campaign_params
      params.require(:campaign).permit(:title, :description)
    end
end
