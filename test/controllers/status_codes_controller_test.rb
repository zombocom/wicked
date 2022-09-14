require 'test_helper'

class StatusCodesControllerTest < WickedControllerTestCase
  test 'returns successful status code for show' do
    get :show, params: { id: 'good' }
    assert_response(:success)
  end

  test 'returns correct status code for successfuly update' do
    put :update, params: { id: 'good' }
    assert_response(:redirect)
  end

  test 'returns correct status code for failed update' do
    put :update, params: { id: 'bad' }
    assert_response(:unprocessable_entity)
  end
end
