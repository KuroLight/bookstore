class ApplicationController < ActionController::Base
  before_filter :authorize
  before_filter :store_location
  protect_from_forgery
  
  # add by TFY, 2012.06.01
  # 用户保存登录或注册前地址
  def store_location
    if request.get? and controller_name != "users" and controller_name != "sessions"
      $last_url = request.url
    end
  end
  # 找到当前用户，若已登录，则返回当前用户，否则返回空值
  def current_user
    User.find_by_id(session[:user_id])
  rescue ActiveRecord::RecordNotFound
    return nil
  end
  # 判断登录的角色
  def login_as_common_user
    if current_user
      return current_user.is_user
    end
    return false
  end
  def login_as_admin
    if current_user
      return current_user.is_admin
    end
    return false
  end
  # end

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
      # unless User.find_by_id(session[:user_id])
      unless current_user
        redirect_to login_url, :notice => "Please log in"
      end
    end
    def admin_authorize
      unless login_as_admin
        redirect_to store_url, :notice => "You are not admin!"
      end
    end
  # end
end
