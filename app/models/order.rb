class Order < ApplicationRecord
  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { wait_payment: 0, confirm_payment: 1, in_production: 2, preparing_to_ship: 3, sent: 4 }
  has_many :order_details, dependent: :destroy
   # 消費税を求めるメソッド
   def with_tax_price
     (self.item.price * 1.1).floor
   end
end
