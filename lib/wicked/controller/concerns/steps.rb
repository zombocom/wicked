module Wicked::Controller::Concerns::Steps
  extend ActiveSupport::Concern

  def jump_to(goto_step)
    @skip_to = goto_step
  end

  def skip_step
    @skip_to = @next_step
  end

  def step
    @step
  end

  # will return true if step passed in is the currently rendered step
  def current_step?(step_name)
    return false if current_and_given_step_exists?(step_name)
    step == step_name
  end

  # will return true if the step passed in has already been executed by the wizard
  def past_step?(step_name)
    return false if current_and_given_step_exists?(step_name)
    current_step_index > step_index_for(step_name)
  end

  # will return true if the step passed in has already been executed by the wizard
  def future_step?(step_name)
    return false if current_and_given_step_exists?(step_name)
    current_step_index < step_index_for(step_name)
  end

  # will return true if the last step is the step passed in
  def previous_step?(step_name)
    return false if current_and_given_step_exists?(step_name)
    (current_step_index - 1)  == step_index_for(step_name)
  end

  # will return true if the next step is the step passed in
  def next_step?(step_name)
    return false if current_and_given_step_exists?(step_name)
    (current_step_index + 1)  == step_index_for(step_name)
  end

  module ClassMethods
    def steps(*args)
      options = args.extract_options!
      steps   = args
      prepend_before_filter(options) do
        self.steps = steps
      end
    end
  end

  def steps=(wizard_steps)
    @wizard_steps = wizard_steps
  end

  def steps
    @wizard_steps
  end
  alias :wizard_steps :steps
  alias :steps_list   :steps

  def previous_step(current_step = nil)
    return @previous_step if current_step == nil
    index =  steps.index(current_step)
    step  =  steps.at(index - 1) if index.present? && index != 0
    step ||= steps.first
    step
  end


  def next_step(current_step = nil)
    return @next_step if current_step == nil
    index = steps.index(current_step)
    step  = steps.at(index + 1) if index.present?
    step  ||= :finish
    step
  end

  private

  def step_index_for(step_name)
    steps.index(step_name)
  end

  def current_step_index
    step_index_for(step)
  end

  def current_and_given_step_exists?(step_name)
    return false if current_step_index.nil? || steps.index(step_name).nil?
  end


end
