class Product < ActiveRecord::Base
  
  #我们需要按照字母表的顺序来显示我们数据库中的商品，
  #我们可以在Product model中添加一个default_scope的调用来实现该功能。
  #default_scope在这个model开始时将会应用到所有的查询中。
  default_scope :order => 'title'
  
  # validation stuff...
  
  attr_accessible :description, :image_url, :price, :title
  # check and guarantee the title, description and image_url not be blank
  validates :title, :description, :image_url, :presence => true
  # check and guarantee the price be >= 0.01
  validates :price, :numericality => {:greater_than_or_equal_to => 0.01}
  # check and guarantee the title be unique
  validates :title, :uniqueness => true
  # check and guarantee the image be in the right format
  validates :image_url, :format => {
  :with => %r{\.(gif|jpg|png)$}i,
  :message => 'must be a URL for GIF, JPG or PNG image.'
  }  
end

