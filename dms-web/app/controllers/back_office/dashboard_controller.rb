# frozen_string_literal: true

class BackOffice::DashboardController < BackOffice::BaseController
  def index
    @open_campaigns = Campaign.open_status
    # We execute this in the view so that the partial rendered by the
    # Turbo-stream broadcast can render itself. TODO: is this really the right way
    # @recent_transactions = BundleTransaction.recent_transactions
  end
end
