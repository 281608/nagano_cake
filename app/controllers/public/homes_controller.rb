class Public::HomesController < ApplicationController
 # before_action :authenticate_customer!
  def top
   @items = Item.all.order(created_at: "DESC").limit(4)
  end

  def about
  end
end
