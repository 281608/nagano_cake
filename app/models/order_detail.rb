class OrderDetail < ApplicationRecord
  enum making_status: { wait: 0, wait_making: 1, making: 2, making_completed: 3 }
  belongs_to :order
  belongs_to :item
  def subtotal
  item.with_tax_price * quantity
  end
end
