require 'test_helper'

class SpecificTemplatetTest < ActiveSupport::IntegrationCase
  test 'renders specific template of a random step' do
    step = SpecificTemplateController::Steps.random.first
    visit(specific_template_path(step))
    assert_has_content?(step)
  end

  test 'renders step template' do
    step = 'first'
    visit(specific_template_path(step))
    assert_has_content?('first')
  end
end
