class UsersController < ApplicationController
  skip_before_filter :authorize, :only => [:new, :create]
  before_filter :store_location
  # GET /users
  # GET /users.json
  def index
    @users = User.order(:name)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    
    unless login_as_admin
      @user.role = 'Register_User'       
    end
    
    respond_to do |format|
      if @user.save
        # 在users_controller.rb的create函数中，判断并定义role
        # by TYF, 2012, 05, 30
        # if the user has been login, that means he's admin??? 这句话有点问题……
        unless login_as_admin
          session[:user_id] = @user.id           
          format.html { redirect_to $last_url || store_url, :notice => "Signed up, User!" }
          format.json { render :json => @user, :status => :created, :location => @user }          
        end
        # end
        format.html { redirect_to(users_url, :notice => "User #{@user.name} was successfully created.") }
        format.json { render :json => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(users_url, :notice => "User #{@user.name} was successfully updated.") }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    begin
      @user.destroy
      flash[:notice] = "User #{@user.name} deleted"
    rescue Exception => e
      flash[:notice] = e.message
    end

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
