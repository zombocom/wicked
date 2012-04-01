require 'test_helper'

class HelpersTest < ActiveSupport::IntegrationCase

  test 'next_wizard_path' do
    step = :first
    visit(bar_path(step))
    click_link 'skip'
    assert has_content?('second')
  end

  test 'wizard_path' do
    step = :first
    visit(bar_path(step))
    click_link 'current'
    assert has_content?(step.to_s)
  end

  test 'wizard_path with symbol arg' do
    step = :first
    visit(bar_path(step))
    click_link 'last'
    assert has_content?('last_step')
  end

  test 'previous_wizard_path' do
    step = :second
    visit(bar_path(step))
    click_link 'previous'
    assert has_content?("first")
  end

end
