class StringStepsController < ApplicationController
  include Wicked::Wizard
  steps 'first', 'second', 'last_step'

  def show
    render_wizard
  end

  def update
  end
end
