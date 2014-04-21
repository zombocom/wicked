require 'test_helper'

class RedirectToNextTest < ActiveSupport::IntegrationCase
  test 'redirect_to_next without options' do
    step = :first
    visit(redirect_to_next_path(step, :jump_to => :last_step))
    assert_has_content?('last_step')
  end

  test 'redirect_to_next with options' do
    step = :first
    visit(redirect_to_next_path(step, :jump_to => :last_step, :notice => 'jump notice'))
    assert_has_content?('last_step')
    assert_has_content?('notice:jump notice')
  end

  test 'redirect_to_finish_wizard without options' do
    step = :first
    visit(redirect_to_next_path(step, :jump_to => :finish_wizard))
    assert_has_content?('home')
  end

  test 'redirect_to_finish_wizard with options' do
    step = :first
    visit(redirect_to_next_path(step, :jump_to => :finish_wizard, :notice => 'jump notice'))
    assert_has_content?('home')
    assert_has_content?('notice:jump notice')
  end
end