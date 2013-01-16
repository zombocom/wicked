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

    # forward to first step with whatever params are provided
    def index
      redirect_to wizard_path(steps.first, clean_params)
    end

    private

    def clean_params
      params.except(:action, :controller)
    end

    def check_redirect_to_first_last!(step)
      redirect_to wizard_path(steps.first) if step.to_s == 'wizard_first'
      redirect_to wizard_path(steps.last)  if step.to_s == 'wizard_last'
    end

    def setup_step_from(the_step)
      the_step = the_step || steps.try(:first)
      check_redirect_to_first_last!(the_step)
      step = steps.detect {|stp| stp.to_s == the_step } if steps.present? && the_step.present?
      return step || the_step
    end

    def check_steps!(the_step)
      return false if step.nil?
      raise "Wicked Wizard steps expected but not yet set, if setting via `before_filter` use `prepend_before_filter`" if steps.nil?
    end

    def setup_wizard
      @step          = setup_step_from(params[:id])
      check_steps!(@step)
      @previous_step = previous_step(@step)
      @next_step     = next_step(@step)
    end
    public
  end
end

