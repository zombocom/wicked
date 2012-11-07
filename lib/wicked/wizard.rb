module Wicked
  module Wizard
    extend ActiveSupport::Concern

    # Include the modules!!
    include Wicked::Controller::Concerns::Path
    include Wicked::Controller::Concerns::RenderRedirect
    include Wicked::Controller::Concerns::Steps

    included do
      # Give our Views helper methods!
      helper_method :wizard_path,     :next_wizard_path, :previous_wizard_path,
                    :step,            :wizard_steps,     :current_step?,
                    :past_step?,      :future_step?,     :previous_step?,
                    :next_step?
      # Set @step and @next_step variables
      before_filter :setup_wizard
    end

    def index
      redirect_to wizard_path(steps.first)
    end

    private

    def check_redirect_to_first_last!(step)
      redirect_to wizard_path(steps.first) if step == :wizard_first
      redirect_to wizard_path(steps.last)  if step == :wizard_last
    end

    def setup_step_from(the_step)
      the_step = the_step.try(:to_sym) || steps.first
      check_redirect_to_first_last!(the_step)
      return the_step
    end

    def setup_wizard
      @step          = setup_step_from(params[:id])
      @previous_step = previous_step(@step)
      @next_step     = next_step(@step)
    end
    public
  end
end