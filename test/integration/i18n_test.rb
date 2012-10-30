require 'test_helper'

class I18nTest < ActiveSupport::IntegrationCase

  test 'renders in spanish' do
    step = :uno
    visit(i18n_path(step, :locale => :es))
    assert has_content?('uno')
    puts "=====================\n"
    puts i18n_path(:dos).inspect
    puts "^^^^^^^^^^^^^^^^^^^^^\n"
    puts page.html
    assert has_link?('hello', :href => i18n_path(:dos))
  end

  test 'renders in english' do
    step = :first
    visit(i18n_path(step, :locale => :en))
    assert has_content?('first')
    puts "=====================\n"
    puts i18n_path(:second).inspect
    puts "^^^^^^^^^^^^^^^^^^^^^\n"
    puts page.html
    assert has_link?('hello', :href => i18n_path(:second))
  end
end
