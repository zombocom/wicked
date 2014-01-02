class OverrideTemplatesController < ApplicationController
  include Wicked::Wizard
  steps :first, :second, :last

  def show
    render_wizard
  end

  private
    def wizard_step_template(the_step)
      the_step == :first ? the_step : :override
    end
end
