require 'test_helper'

class BarControllerTest < ActionController::TestCase
  test 'index redirects to the first step' do
    get :index
    assert_redirected_to bar_path(:first)
  end

  test 'index redirects to the first step, preserving query args' do
    get :index, :some => 'arguments', :were => 'passed'
    assert_redirected_to bar_path(:first, :some => 'arguments', :were => 'passed')
  end
end