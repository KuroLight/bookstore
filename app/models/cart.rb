class Cart < ActiveRecord::Base
  # attr_accessible :title, :body
  
  # add by TFY, 2012.05.09
  # has_many描述了cart和line_item间的关系，
  # 一个购物车中可以有多个item。
  # :dependent=> :destroy部分表示line_item中存在的数据依赖于cart，
  # 删除一个购物车的话将需要同时删除line_item中该购物车相应的数据。
  has_many :line_items, :dependent => :destroy
  # end
  
  def add_product(product_id)
    current_item = line_items.find_by_product_id(product_id)
    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(:product_id => product_id)
    end
    current_item
  end
  
  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end

end