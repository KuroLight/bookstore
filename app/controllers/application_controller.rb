class ApplicationController < ActionController::Base
  protect_from_forgery
  
  # add by TFY, 2012.05.09
  private

    def current_cart 
      Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
      cart = Cart.create
      session[:cart_id] = cart.id
      cart
    end
  # end
end
