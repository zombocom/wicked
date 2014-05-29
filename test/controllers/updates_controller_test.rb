require 'test_helper'

class UpdatesControllerTest < ActionController::TestCase
  test 'redirect from first step to second step' do
    put :update, :id => 'first'
    assert_redirected_to update_path(:second)
    assert_equal 'Thing was updated from step first.', flash[:notice]
  end

  test 'redirect from second step to final step' do
    put :update, :id => 'second'
    assert_redirected_to update_path(:last_step)
    assert_equal 'Thing was updated from step second.', flash[:notice]
  end

  test 'redirect from last_step to root path' do
    put :update, :id => 'last_step'
    assert_redirected_to update_path(:wicked_finish)
    assert_equal 'Thing was updated from step last_step.', flash[:notice]
  end

  test 'redirect from wicked_finish to root path' do
    get :show, {:id => Wicked::FINISH_STEP}, {}, {:notice => "flash from last_step"}
    assert_redirected_to updates_path
    assert_equal 'flash from last_step', flash[:notice]
  end
end
