## This controller uses includes

class StepPositions2Controller < ApplicationController
  include Wicked::Wizard
  steps :first, :second, :last_step

  def edit
    render_wizard
  end

  def update
  end
end
