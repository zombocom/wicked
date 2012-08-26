require 'test_helper'

class InheritNavigationTest < ActiveSupport::IntegrationCase

  test 'default index' do
    visit(foo_index_path)
    assert has_content?('first')
  end

  test 'show first' do
    step = :first
    visit(foo_path(step))
    assert has_content?(step.to_s)
  end

  test 'show second' do
    step = :second
    visit(foo_path(step))
    assert has_content?(step.to_s)
  end

  test 'skip first' do
    step = :first
    visit(foo_path(step.to_s, :skip_step => 'true'))
    assert has_content?('second')
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

class InheritNavigationEditTest < ActiveSupport::IntegrationCase
  test 'edit first' do
    step = :first
    visit(edit_foo2_path(nil, step: step))
    assert has_content?(step.to_s)
  end

  test 'edit second' do
    step = :second
    visit(edit_foo2_path(nil, step: step))
    assert has_content?(step.to_s)
  end

  test 'skip first edit' do
    step = :first
    visit(edit_foo2_path(nil, skip_step: 'true', step: step))
    assert has_content?('second')
  end

  test 'invalid edit step' do
    step = :notastep
    assert_raise(ActionView::MissingTemplate) do
      visit(edit_foo2_path(nil, step: step))
    end
  end

  test 'finish edit' do
    step = :finish
    visit(edit_foo2_path(nil, step: step))
    assert has_content?('home')
  end

end

class IncludeNavigationTest < ActiveSupport::IntegrationCase

  test 'show first' do
    step = :first
    visit(bar_path(step))
    assert has_content?(step.to_s)
  end

  test 'show second' do
    step = :second
    visit(bar_path(step))
    assert has_content?(step.to_s)
  end

  test 'skip first' do
    step = :first
    visit(bar_path(step, :skip_step => 'true'))
    assert has_content?(:second.to_s)
  end

  test 'pointer to first' do
    visit(bar_path(:wizard_first))
    assert has_content?('first')
  end

  test 'pointer to last' do
    visit(bar_path(:wizard_last))
    assert has_content?('last_step')
  end

  test 'invalid step' do
    step = :notastep
    assert_raise(ActionView::MissingTemplate) do
      visit(bar_path(step))
    end
  end

  test 'finish' do
    step = :finish
    visit(bar_path(step))
    assert has_content?('home')
  end

end

class IncludeNavigationEditTest < ActiveSupport::IntegrationCase

  test 'edit first' do
    step = :first
    visit(edit_bar2_path(step))
    assert has_content?(step.to_s)
  end

  test 'edit second' do
    step = :second
    visit(edit_bar2_path(step))
    assert has_content?(step.to_s)
  end

  test 'skip first edit' do
    step = :first
    visit(edit_bar2_path(step, :skip_step => 'true'))
    assert has_content?(:second.to_s)
  end

  test 'pointer to first edit' do
    visit(edit_bar2_path(:wizard_first))
    assert has_content?('first')
  end

  test 'pointer to last edit' do
    visit(edit_bar2_path(:wizard_last))
    assert has_content?('last_step')
  end

  test 'invalid edit step' do
    step = :notastep
    assert_raise(ActionView::MissingTemplate) do
      visit(edit_bar2_path(step))
    end
  end

  test 'finish edit' do
    step = :finish
    visit(edit_bar2_path(step))
    assert has_content?('home')
  end

end
