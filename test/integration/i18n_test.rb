require 'test_helper'

class I18nTest < ActiveSupport::IntegrationCase

  test 'renders in spanish' do
    step = :uno
    visit(i18n_path(step, :locale => :es))
    assert has_content?('uno')

    ## Needed to keep travis build working on 1.8.7 idk why
    i18n_path(:dos)
    page.html

    assert has_link?('hello', :href => i18n_path(:dos))
  end

  test 'renders in english' do
    step = :first
    visit(i18n_path(step, :locale => :en))
    assert has_content?('first')

    ## Needed to keep travis build working on 1.8.7 idk why
    i18n_path(:second)
    page.html

    assert has_link?('hello', :href => i18n_path(:second))
  end
end
