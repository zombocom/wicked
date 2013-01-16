## This controller uses includes

class StepPositionsController < ApplicationController
  include Wicked::Wizard
  steps :first, :second, :last_step

  def show
    case step
    when :first
    when :second
    when :last_step
    else
      raise "error #{step.inspect}"
    end
    render_wizard
  end

  def update
  end
end
