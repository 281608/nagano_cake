class Public::OrdersController < ApplicationController
  before_action :order_new, only: [:new]
  def new
    @order = Order.new
    @customer = current_customer
  end

  def index
    @orders = Order.page(params[:page])
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    @order = Order.new(order_params)
    @order.save
    @cart_items = current_customer.cart_items
    @cart_items.each do |cart_item|
    @order_detail = OrderDetail.new
    @order_detail.item_id = cart_item.item_id
    @order_detail.quantity = cart_item.amount
    @order_detail.order_id = @order.id
    @order_detail.price = cart_item.item.price
    @order_detail.making_status = 0
    @order_detail.save
    cart_item.destroy
    end
    redirect_to orders_thanks_path
  end

  def confirm
    @order = Order.new(order_params)
    @cart_items = current_customer.cart_items
    @shipping_address = ShippingAddress.find(params[:order][:address_id])
    @order.customer_id = @shipping_address.customer_id
     if params[:order][:address_option] == "0"
       @order.postal_code = current_customer.postal_code
       @order.address = current_customer.address
       @order.name = current_customer.full_name
     elsif params[:order][:address_option] == "1"
       @order.postal_code = @shipping_address.postal_code
       @order.address = @shipping_address.address
       @order.name = @shipping_address.name
     elsif params[:order][:address_option] == "2"
       @order.postal_code = params[:order][:postal_code]
       @order.address = params[:order][:address]
       @order.name = params[:order][:name]
     end
    @order.postage = 800
    @cart_item_total = 0
    @order.billing_amount = 0
  end

  def thanks
  end

  def order_new
    if current_customer.cart_items.empty?
       redirect_to cart_items_path
    end
  end

 private

  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :postage, :billing_amount, :payment_method, :status)
  end
end
