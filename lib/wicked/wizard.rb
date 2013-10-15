module Wicked
  module Wizard
    extend ActiveSupport::Concern

    class InvalidStepError < RuntimeError
      def initialize
        super "The requested step did not match any steps defined for this controller."
      end
    end

    class UndefinedStepsError < RuntimeError
      def initialize
        super "No step definitions have been supplied; if setting via `before_filter`, use `prepend_before_filter`"
      end
    end

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
      redirect_to "#{wizard_path(steps.first)}?#{request.query_parameters.to_query}"
    end

    # returns the canonical value for a step name, needed for translation support
    def wizard_value(step_name)
      step_name
    end

    private

    def check_redirect_to_first_last!(step)
      redirect_to wizard_path(steps.first) if step.to_s == Wicked::FIRST_STEP
      redirect_to wizard_path(steps.last)  if step.to_s == Wicked::LAST_STEP
    end

    def setup_step_from(the_step)
      return if steps.nil?

      the_step ||= steps.first
      check_redirect_to_first_last!(the_step)

      valid_steps = steps + self.class::PROTECTED_STEPS
      the_step = valid_steps.detect { |stp| stp.to_s == the_step }

      raise InvalidStepError if the_step.nil?
      the_step
    end

    def check_steps!
      raise UndefinedStepsError if steps.nil?
    end

    def set_previous_next(step)
      @previous_step = previous_step(@step)
      @next_step     = next_step(@step)
    end

    def setup_wizard
      check_steps!
      return if params[:id].nil?

      @step = setup_step_from(params[:id])
      set_previous_next(@step)
    end
    public
  end
end

