class Admin::OrdersDetailsController < ApplicationController
  def update_making
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    @order_detail.update(order_detail_params)
    if change_status(@order)
      @order.update(status: "preparing_to_ship")
    end
    redirect_to admin_order_path(@order_detail.order)
  end

  def change_status(order)
    order.order_details.each do |order_detail|
      if order_detail.making_status != 'making_completed'
        return false
      end
    end
    return true
  end

 private

  def order_detail_params
    params.require(:order_detail).permit(:item_id, :order_id, :price, :quantity, :making_status)
  end

end
