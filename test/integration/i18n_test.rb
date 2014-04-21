# encoding: UTF-8

require 'test_helper'

class I18nTest < ActiveSupport::IntegrationCase

  test 'renders in spanish' do
    step = :uno
    visit(i18n_path(step, :locale => :es))
    assert_has_content?("Hey ya'll we're looking at: uno")
    assert has_link?('hello', :href => i18n_path(:dos))
    assert_has_content?('uno step is the current step')      # current_step?
    assert true                                              # past_step?
    assert_has_content?('dos step is a future step')         # future_step?
    assert_has_content?('último_paso step is a future step') # future_step?
    assert true                                              # previous_step?
    assert_has_content?('dos step is the next step')         # next_step?
  end

  test 'renders in english' do
    step = :first
    visit(i18n_path(step, :locale => :en))
    assert_has_content?("Hey ya'll we're looking at: first")
    assert has_link?('hello', :href => i18n_path(:second))

    assert_has_content?('first step is the current step')   # current_step?
    assert true                                             # past_step?
    assert_has_content?('last_step step is a future step')  # future_step?
    assert_has_content?('second step is a future step')     # future_step?
    assert true                                             # previous_step?
    assert_has_content?('second step is the next step')     # next_step?
  end

  test 'wizard_value works on i18n pages' do
    step = :dos
    visit(i18n_path(step, :locale => :es))
    assert_has_content?("wizard_value for first: first")
    assert_has_content?("wizard_value for second: second")

    step = :second
    visit(i18n_path(step, :locale => :en))
    assert_has_content?("wizard_value for first: first")
    assert_has_content?("wizard_value for second: second")
  end
end
