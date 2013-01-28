require 'test_helper'

class StepPositionsTest < ActiveSupport::IntegrationCase

  test 'on first' do
    step = :first
    visit(step_position_path(step))
    assert has_content?('first step is the current step')   # current_step?
    assert true                                             # past_step?
    assert has_content?('last_step step is a future step')  # future_step?
    assert has_content?('second step is a future step')     # future_step?
    assert true                                             # previous_step?
    assert has_content?('second step is the next step')     # next_step?
  end

  test 'on second' do
    step = :second
    visit(step_position_path(step))
    assert has_content?('second step is the current step')  # current_step?
    assert has_content?('first step is a past step')        # past_step?
    assert has_content?('last_step step is a future step')  # future_step?
    assert has_content?('first step was the previous step') # previous_step?
    assert has_content?('last_step step is the next step')  # next_step?
  end

  test 'string-based steps' do
    visit(string_step_path('second'))
    assert has_content?('second step is the current step')  # current_step?
    assert has_content?('first step is a past step')        # past_step?
    assert has_content?('last_step step is a future step')  # future_step?
    assert has_content?('first step was the previous step') # previous_step?
    assert has_content?('last_step step is the next step')  # next_step?
  end
end

  # current_step?
  # past_step?
  # future_step?
  # previous_step?
  # next_step?
