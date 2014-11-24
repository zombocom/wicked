require 'test_helper'

class RenderWithBlockControllerTest < ActionController::TestCase
  test 'render_wizard yields passed block' do
    patch :update, id: :second 
    assert($stdout, :puts)
  end
end
