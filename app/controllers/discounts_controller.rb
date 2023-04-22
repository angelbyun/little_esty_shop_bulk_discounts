class DiscountsController < ApplicationController
  before_action :find_merchant, only: [:new, :create, :index]

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @discounts = Discount.all
  end

  def show
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @discount = @merchant.discounts.new
  end
  
  def create
    @merchant = Merchant.find(params[:merchant_id])
    @discount = @merchant.discounts.new(discount_params)
    if @discount.save
      redirect_to "/merchant/#{discount_params[:merchant_id]}/discounts"
    else
      flash[:alert] = "Information Required!"
      render :new
    end
  end

  def destroy
    # require 'pry'; binding.pry
    discount = Discount.find(params[:id])
    discount.destroy
    redirect_to "/merchant/#{discount_params[:merchant_id]}/discounts"
  end

  private
  def discount_params
    params.permit(:item_quantity, :discount, :merchant_id)
  end

  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end
end