require 'test_helper'

class OverrideTemplatesControllerTest < ActionController::TestCase
  test 'allow override of the rendered template name depending on the_step' do
    get :show, :id => "first"
    assert_template :first

    get :show, :id => :second
    assert_template :override

    get :show, :id => "last"
    assert_template :override
  end
end
