class SessionsController < ApplicationController
  # sessions 不需要任何权限即可浏览
  skip_before_filter :authorize
  skip_before_filter :admin_authorize
  before_filter :store_location
  def new
  end

  # 创建一个signup路径，同时将signup与new user页面关联起来,
  # by TYF, 2012, 05, 30
  def sign_up
    redirect_to "/users/new"
  end
  # end

  def create
    if user = User.authenticate(params[:name], params[:password])
      session[:user_id] = user.id
      # 一般用户登录后跳转回原来的页面
      if user.is_admin
        redirect_to admin_url, :notice => "Logged in, Admin!"
      else 
        redirect_to $last_url || store_url, :notice => "Logged in, User!"
      end
      # end      
    else
      redirect_to login_url, :alert => "Invalid user/password combination"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to store_url, :notice => "Logged out"
  end
end
