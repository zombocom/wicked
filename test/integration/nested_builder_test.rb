require 'test_helper'

class NestedBuilderTest < ActiveSupport::IntegrationCase

  test 'can use nested ids' do
    visit nested_builder_path(:id => :last_step, :nested_id => "foo")
    assert_has_content?("last")
    assert_has_content?("params[:nested_id] foo")
  end

  test 'forwards nested ids' do
    visit nested_builder_path(:id => :last_step, :nested_id => "foo")
    assert_has_content?("last")
    click_link 'next'
    assert_has_content?("home")
  end

  test 'updates nested id param value after creating new records' do
    visit nested_builder_path(:id => :first, :nested_id => "new")
    click_button 'Create Nested'
    assert_has_content?("second")
    assert_equal(nested_builder_path(:id => :second, :nested_id => "persisted"), current_path)
  end
end
