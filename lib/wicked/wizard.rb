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
    def setup_wizard
      routes_config = Wicked::Wizard.class_variable_get :@@routes_config if Wicked::Wizard.class_variable_defined? :@@routes_config
      routes_config = routes_config && routes_config[self.class.name] || {}
      @step_parameter = routes_config[:step_parameter] || :id
      @step_action = routes_config[:step_action] || 'show'

      redirect_to wizard_path(steps.first) if params[@step_parameter].try(:to_sym) == :wizard_first
      redirect_to wizard_path(steps.last)  if params[@step_parameter].try(:to_sym) == :wizard_last

      @step          = params[@step_parameter].try(:to_sym) || steps.first
      @previous_step = previous_step(@step)
      @next_step     = next_step(@step)
    end
    public
  end
end