require 'test_helper'

class JumpNavigationTest < ActiveSupport::IntegrationCase
  test 'consider jump_to when calling render_wizard with resource' do
    step = :first
    visit(jump_path(step, :resource => {:save => true}, :jump_to => :last_step))
    assert_has_content?('last_step')
  end

  test 'disregard jump_to when saving the resource fails' do
    step = :first
    visit(jump_path(step, :resource => {:save => false}, :jump_to => :last_step))
    assert_has_content?('first')
    assert !has_content?('last_step')
  end


  test 'skip_step takes :skip_step_options and passes them' do
    step = :first
    visit(jump_path(step, :skip_step => true, :skip_step_options => {:foo => :bar}))
    assert_has_content?('second')
    assert !has_content?('last_step')
  end

  test 'jump_to takes :skip_step_options and passes them' do
    step = :first
    visit(jump_path(step, :resource => {:save => true}, :jump_to => :last_step, :skip_step_options => {:foo => :bar}))
    assert_has_content?("foo")
    assert_has_content?("bar")
    assert_has_content?('last_step')
  end
end