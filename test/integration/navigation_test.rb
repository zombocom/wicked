require 'test_helper'

class NavigationTest < ActiveSupport::IntegrationCase

  test 'show first' do
    step = :first
    visit(foo_path(step))
    assert has_content?(step)
  end

  test 'show second' do
    step = :second
    visit(foo_path(step))
    assert has_content?(step)
  end

  test 'skip first' do
    step = :first
    visit(foo_path(step, :skip_step => 'true'))
    assert has_content?(:second)
  end

  test 'invalid step' do
    step = :notastep
    assert_raise(ActionView::MissingTemplate) do
      visit(foo_path(step))
    end
  end

  test 'finish' do
    step = :finish
    visit(foo_path(step))
    assert has_content?('home')
  end

end
