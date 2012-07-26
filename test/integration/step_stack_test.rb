require 'test_helper'

class StepStackTest < ActiveSupport::IntegrationCase
  test 'previous link points to last visited step' do
    step = :first
    visit(bar_path(step))
    click_link 'last'
    click_link 'previous'
    assert has_content?(step.to_s)
  end
end