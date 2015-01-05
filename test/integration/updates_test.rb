require 'test_helper'

class UpdatesTest < ActiveSupport::IntegrationCase
  test 'on first' do
    step = :first
    visit(update_path(step))

    click_button("Next")
    assert_equal page.current_path, update_path(:second)
    assert_has_content?("notice:Thing was updated from step first.")

    click_button("Next")
    assert_equal page.current_path, update_path(:last_step)
    assert_has_content?("notice:Thing was updated from step second.")

    click_button("Next")
    assert_equal page.current_path, updates_path
    assert_has_content?("notice:Thing was updated from step last_step.")
  end
end
