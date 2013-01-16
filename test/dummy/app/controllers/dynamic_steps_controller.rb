class DynamicStepsController < ApplicationController
  include Wicked::Wizard
  prepend_before_filter :set_steps

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
