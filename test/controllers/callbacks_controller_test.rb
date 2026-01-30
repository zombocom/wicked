require 'test_helper'

class CallbacksControllerTest < WickedControllerTestCase
  def setup
    CallbacksController::CallbackCounter.reset
  end

  test 'callback is executed when resource saves successfully' do
    put :update, params: { id: 'success_step' }

    assert_equal 1, CallbacksController::CallbackCounter.count,
                 'Expected callback to increment counter by 1 when save succeeds'
    assert_response :redirect
  end

  test 'callback is not executed when resource fails to save' do
    put :update, params: { id: 'failure_step' }

    assert_equal 0, CallbacksController::CallbackCounter.count,
                 'Expected callback NOT to increment counter when save fails'
    assert_response :unprocessable_entity
  end
end
