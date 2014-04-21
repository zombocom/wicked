require 'test_helper'

class DynamicStepsTest < ActiveSupport::IntegrationCase
  test 'set dynamic steps from params' do
    steps = ['first', 'second']
    visit dynamic_steps_path(:steps => steps)
    assert_has_content?(steps.first.inspect)
    assert_has_content?(steps.inspect)
  end
end
