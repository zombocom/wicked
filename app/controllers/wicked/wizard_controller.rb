# Please don't re-use any patterns in this controller,
# they work, but are not very good practices.
# If you have a better way to do this, please let me know

class Wicked::WizardController < ApplicationController
  before_filter :setup_wizard

  # steps :confirm_password, :invite_fb

  # example show action
  # def show
  #   case step
  #   when :confirm_password
  #     redirect_to_next(@next_step) and return nil unless @user.facebook?
  #   when :invite_fb
  #     redirect_to_next(@next_step) and return nil unless @user.facebook?
  #   end
  #   render_wizard
  # end


  # example update action
  # def update
  #   case step
  #   when :confirm_password
  #     @user.update_attributes(params[:user])
  #   when :confirm_profile
  #     @user.update_attributes(params[:user])
  #   end
  #   sign_in(@user, :bypass => true) # needed for devise
  #   render_wizard
  # end

  private

  # scary and gross, allows for double render
  def reset_invocation_response
    self.instance_variable_set(:@_response_body, nil)
    response.instance_variable_set :@header, Rack::Utils::HeaderHash.new("cookie" => [], 'Content-Type' => 'text/html')
  end


  def path_for(step)
    path_array = URI.parse(request.url).path.split('/')
    path_array.pop
    path_array.push(step)
    path_array.join('/')
  end

  def render_wizard(resource = nil)
    @skip_to = @next_step if resource && resource.save
    if @skip_to.present?
      redirect_to path_for(@skip_to)
    else
      reset_invocation_response
      render_step @step
    end
  end

  def skip_step
    @skip_to = @next_step
  end


  def setup_wizard
    @step      = params[:id].to_sym
    @next_step = next_step(@step) || :finish
  end

  def step
    @step
  end

  def self.steps=(steps)
    @wizard_steps = steps
  end

  def class.steps(steps = nil)
    @wizard_steps = steps unless steps.blank?
    @wizard_steps
  end

  def steps
    self.class.steps
  end

  def render_step(step)
    if step.nil? || step == :finish
      redirect_to_finish
    else
      render step
    end
  end


  def next_step(current_step)
    index = steps.index(current_step)
    if index.present? && index < steps.length
      return steps.at(index + 1)
    else
      return nil
    end
  end

  def redirect_to_next(next_step)
    if next_step.nil?
      redirect_to_finish
    else
      redirect_to path_for(next_step)
    end
  end

  def redirect_to_finish
    redirect_to previous_path_or(root_path)
  end
end

module Wicked
  Wizard = Wicked::WizardController
end
