class AdminController < ApplicationController
  before_filter :store_location
  def index
    @total_orders = Order.count
  end
end
