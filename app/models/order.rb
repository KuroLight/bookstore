# encoding: utf-8

class Order < ActiveRecord::Base
  attr_accessible :address, :email, :name, :pay_type
  PAYMENT_TYPES = [ "Cash现金", "Alipay支付宝", "Free霸王书！" ]
  
  validates :name, :address, :email, :pay_type, :presence => true
  validates :pay_type, :inclusion => PAYMENT_TYPES
  
  has_many :line_items, :dependent => :destroy
  
  # add by TFY, 2012.06.02
  belongs_to :user
  # end
  
  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end
end
