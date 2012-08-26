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

      self.class_attribute :wicked_step_parameter, instance_writer: false unless defined? wicked_step_parameter
      self.wicked_step_parameter ||= :id
      self.class_attribute :wicked_step_action, instance_writer: false unless defined? wicked_step_action
      self.wicked_step_action ||= 'show'
    end

    def index
      redirect_to wizard_path(steps.first)
    end

    private
    def setup_wizard
      redirect_to wizard_path(steps.first) if params[wicked_step_parameter].try(:to_sym) == :wizard_first
      redirect_to wizard_path(steps.last)  if params[wicked_step_parameter].try(:to_sym) == :wizard_last

      @step          = params[wicked_step_parameter].try(:to_sym) || steps.first
      @previous_step = previous_step(@step)
      @next_step     = next_step(@step)
    end
    public
  end
end