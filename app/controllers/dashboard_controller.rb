class DashboardController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @bundle_discount = BundleDiscount.find(params[:id])
  end
end
