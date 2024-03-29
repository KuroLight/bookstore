class LineItemsController < ApplicationController
  # line_items 不需要任何权限即可create
  skip_before_filter :authorize, :only => :create
  skip_before_filter :admin_authorize, :only => :create
  before_filter :store_location

  # GET /line_items
  # GET /line_items.json
  def index
    @line_items = LineItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @line_items }
    end
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
    @line_item = LineItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @line_item }
    end
  end

  # GET /line_items/new
  # GET /line_items/new.json
  def new
    @line_item = LineItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @line_item }
    end
  end

  # GET /line_items/1/edit
  def edit
    @line_item = LineItem.find(params[:id])
  end

  # POST /line_items
  # POST /line_items.json
  def create
    @cart = current_cart
    product = Product.find(params[:product_id])
    # 下面这句有点问题！ by TYF, 2012.05.09
    # @line_item = @cart.line_items.build(:product => product)
    # 替换为下面这两句
    # 第二次修改，删除下面两句，换成第三四句。 by TYF, 2012.05.10
    # @line_item = @cart.line_items.build
    # @line_item.product = product
    @line_item = @cart.add_product(product.id)

    respond_to do |format|
      if @line_item.save
        # 删除添加Line Item时自动产生的flash消息
        # format.html { redirect_to @line_item.cart, :notice => 'Line item was successfully created.' }
        format.html { redirect_to(store_url) }
        # format.js 查找create.js.rjs，但是rjs模版在3.2.2已经移除……所以看create.js.coffee里面实现！
        format.js   { @current_item = @line_item}
        format.json { render :json => @line_item, :status => :created, :location => @line_item }
      else
        format.html { render :action => "new" }
        format.json { render :json => @line_item.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /line_items/1
  # PUT /line_items/1.json
  def update
    @line_item = LineItem.find(params[:id])

    respond_to do |format|
      if @line_item.update_attributes(params[:line_item])
        format.html { redirect_to @line_item, :notice => 'Line item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @line_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    @line_item = LineItem.find(params[:id])
    @line_item.destroy

    respond_to do |format|
      format.html { redirect_to line_items_url }
      format.json { head :no_content }
    end
  end
end
