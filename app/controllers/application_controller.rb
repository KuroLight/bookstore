class ApplicationController < ActionController::Base
  before_filter :authorize
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
  
  # add by TFY, 2012.05.29
  protected

    def authorize
      unless User.find_by_id(session[:user_id])
        redirect_to login_url, :notice => "Please log in"
      end
    end
  # end
end
