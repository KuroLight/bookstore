class StoreController < ApplicationController
  # store/index不需要任何权限即可浏览
  skip_before_filter :authorize
  skip_before_filter :admin_authorize
  before_filter :store_location
  def index
    @products = Product.all
    @cart = current_cart
  end
end
