require 'test_helper'

class RedirectToFinishFlashTest < ActiveSupport::IntegrationCase
  test 'redirect_to_next when in last step' do
    step = :last_step
    visit(redirect_to_finish_flash_path(step))
    click_link 'Next'
    assert has_content?('redirect_to_finish_flash/index')
    assert has_content?('Flash message notice')
  end
end