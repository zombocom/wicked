require 'test_helper'

class SecurityTest < ActiveSupport::IntegrationCase

  test 'does not show database.yml' do
    step = "%2E%2F%2E%2E%2F%2E%2E%2Fconfig%2Fdatabase%2Eyml"
    assert_raise(Wicked::Wizard::InvalidStepError) do
      visit(bar_path(step))
    end
    refute has_content?('sqlite3')
  end

  # only works on *nix systems
  test 'does not show arbitrary system file' do
    root = '%2E%2F%2E' * 100 # root of system
    step = root + '%2Fusr%2Fshare%2Fdict%2Fwords'

    assert_raise(Wicked::Wizard::InvalidStepError) do
      visit(bar_path(step))
    end
    refute has_content?('aardvark')
  end
end
