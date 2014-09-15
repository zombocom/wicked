require 'test_helper'

class DynamicStepsTest < ActiveSupport::IntegrationCase
  test 'set dynamic steps from params using prepend' do
    steps = ['first', 'second']
    visit dynamic_steps_path(:steps => steps)
    assert_has_content?(steps.first.inspect)
    assert_has_content?(steps.inspect)
  end

  test 'set dynamic steps from params without using' do
    steps = ['first', 'second']
    visit dynamic_different_steps_path(:steps => steps)
    assert_has_content?(steps.first.inspect)
    assert_has_content?(steps.inspect)
  end
end
