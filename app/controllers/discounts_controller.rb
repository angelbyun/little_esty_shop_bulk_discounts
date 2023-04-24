class DiscountsController < ApplicationController
  before_action :find_merchant, only: [:new, :create, :index]

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @discounts = Discount.all
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.find(params[:id])
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

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.find(params[:id])
  end

  def update
    @discount = Discount.find(params[:id])
    @discount.update(discount_params)
    redirect_to "/merchant/#{discount_params[:merchant_id]}/discounts/#{@discount.id}"
  end

  def destroy
    discount = Discount.find(params[:id])
    discount.destroy
    redirect_to "/merchant/#{discount_params[:merchant_id]}/discounts"
  end

  private
  def discount_params
    params.permit(:id, :item_quantity, :discount, :merchant_id)
  end

  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end
end