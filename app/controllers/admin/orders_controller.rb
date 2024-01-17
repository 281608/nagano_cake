class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    if @order.status== "confirm_payment"
      OrderDetail.update_all(making_status: "wait_making")
    end
    redirect_to admin_order_path(@order)
  end

 private

  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :postage, :billing_amount, :payment_method, :status)
  end
end
