require 'test_helper'

class JumpNavigationTest < ActiveSupport::IntegrationCase
  test 'consider jump_to when calling render_wizard with resource' do
    step = :first
    visit(jump_path(step, :resource => {:save => true}, :jump_to => :last_step))
    assert has_content?('last_step')
  end

  test 'disregard jump_to when saving the resource fails' do
    step = :first
    visit(jump_path(step, :resource => {:save => false}, :jump_to => :last_step))
    assert has_content?('first')
    assert !has_content?('last_step')
  end
end