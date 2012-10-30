require 'test_helper'

class I18nTest < ActiveSupport::IntegrationCase

  test 'renders in english' do
    step = :first
    visit(i18n_path(step, :locale => :en))
    assert has_content?('first')
    assert has_link?('hello', :href => i18n_path(:second))

  end

  test 'renders in spanish' do
    step = :uno
    visit(i18n_path(step, :locale => :es))
    assert has_content?('uno')
    assert has_link?('hello', :href => i18n_path(:dos))
  end
end