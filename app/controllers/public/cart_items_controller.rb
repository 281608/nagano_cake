class Public::CartItemsController < ApplicationController
  def index
    @cart_items = CartItem.all
    @cart_item_all = 0
  end

  def create
     if CartItem.find_by(customer_id: current_customer.id, item_id: cart_item_params[:item_id])
       @cart_item = CartItem.find_by(customer_id: current_customer.id, item_id: cart_item_params[:item_id])
       @cart_item.update(amount: cart_item_params[:amount].to_i + @cart_item.amount)
     else
       @cart_item = CartItem.new(cart_item_params)
       @cart_item.customer_id = current_customer.id
       @cart_item.save
     end
    redirect_to cart_items_path
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end

  private

def cart_item_params
  params.require(:cart_item).permit(:item_id, :amount)
end
end
