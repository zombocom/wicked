require 'test_helper'

class SettingsControllerTest < ActionController::TestCase
  test 'index shows original index' do
    get :index
    assert_template :index
    
  end
 
end