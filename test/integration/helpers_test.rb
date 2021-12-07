require 'test_helper'

class HelpersTest < ActiveSupport::IntegrationCase

  test 'next_wizard_path' do
    step = :first
    visit(bar_path(step))
    assert has_link?('skip', href: '/bar/second')
    click_link 'skip'
    assert_has_content?('second')
  end

  test 'next_wizard_url' do
    step = :first
    visit(bar_path(step))
    assert has_link?('next url', href: 'http://www.example.com/bar/second')
    click_link 'next url'
    assert_has_content?('second')
  end

  test 'wizard_path' do
    step = :first
    visit(bar_path(step))
    assert has_link?('current', href: '/bar/first')
    click_link 'current'
    assert_has_content?(step.to_s)
  end

  test 'wizard_path with symbol arg' do
    step = :first
    visit(bar_path(step))
    click_link 'last'
    assert_has_content?('last_step')
  end

  test 'wizard_url' do
    step = :first
    visit(bar_path(step))
    assert has_link?('current url', href: 'http://www.example.com/bar/first')
    click_link 'current'
    assert_has_content?(step.to_s)
  end

  test 'previous_wizard_path' do
    step = :second
    visit(bar_path(step))
    assert has_link?('previous', href: '/bar/first')
    click_link 'previous'
    assert_has_content?("first")
  end

  test 'previous_wizard_url' do
    step = :second
    visit(bar_path(step))
    assert has_link?('previous url', href: 'http://www.example.com/bar/first')
    click_link 'previous'
    assert_has_content?("first")
  end

  test 'wizard_steps' do
    step = :last_step
    visit(bar_path(step))
    assert_has_content?("step 3 of 3")
  end

end
