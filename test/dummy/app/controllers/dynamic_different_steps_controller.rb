class DynamicDifferentStepsController < ApplicationController
  include Wicked::Wizard

  before_filter :set_steps
  before_filter :setup_wizard

  def show
    render_wizard
  end


  private
  def set_steps
    self.steps = if params[:steps]
      params[:steps]
    end
  end
end
