require 'test_helper'

class NavigationTest < ActiveSupport::IntegrationCase
  test 'show first' do
    visit(foo_path(:first))
  end

end
