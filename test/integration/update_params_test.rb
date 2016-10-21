require 'test_helper'

class UpdateParamsTest < ActiveSupport::IntegrationCase
  test 'on first' do
    step = :first
    visit(update_param_path(step))

    click_button("Next")
    assert_equal page.current_path, update_param_path(:second)
    assert_has_content?("notice:Thing was updated from step first.")

    click_button("Next")
    assert_equal page.current_path, update_param_path(:last_step)
    assert_has_content?("notice:Thing was updated from step second.")

    click_button("Next")
    assert_equal page.current_url, update_params_url({host: 'www.example.com', one: 'two' })
    assert_has_content?("notice:Thing was updated from step last_step.")
  end
end
