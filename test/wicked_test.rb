require 'test_helper'

class WickedTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, Wicked
  end

  test "protected steps" do
    error = assert_raise WickedProtectedStepError do
      class ProtectedBadStepsController < ApplicationController
        include Wicked::Wizard

        steps :whatever, Wicked::FINISH_STEP
      end
    end
    assert_equal "Protected step detected: '#{Wicked::FINISH_STEP}' is used internally by Wicked please rename your step", error.message
  end
end
