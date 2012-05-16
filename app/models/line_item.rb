class LineItem < ActiveRecord::Base
  attr_accessible :cart_id, :product_id
  # 重大问题！以下这句必须存在，不然出现“Can't mass-assign protected attributes: quantity”
  # add by TYF, 2012.05.11
  attr_accessible :quantity
  
  # add by TFY, 2012.05.09
  belongs_to :product
  belongs_to :cart
  # end
  # add by TFY, 2012.05.16
  belongs_to :order
  # end
  
  def total_price
    product.price * quantity
  end
end
