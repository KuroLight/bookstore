require 'test_helper'

class StoreControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    
    # add test by TYF, 2012.05.09
    # 验证系统的对下面内容的响应
    # 包括：页面布局，产品信息和数字格式。
    assert_select '#columns #side a', :minimum => 4
    assert_select '#main .entry', 3
    assert_select 'h3', 'Programming Ruby 1.9'
    assert_select '.price', /\$[,\d]+\.\d\d/
    # end
  end

end
