module Wicked::Controller::Concerns::Path
  extend ActiveSupport::Concern


  def next_wizard_path(options = {})
    wizard_path(@next_step, options)
  end

  def previous_wizard_path(options = {})
    wizard_path(@previous_step, options)
  end

  def wicked_controller
    params[:controller]
  end

  def wicked_action
    params[:action]
  end


  def wizard_path(goto_step = nil, options = {})
    options = { :controller => wicked_controller,
                :action     => @step_action,
                @step_parameter.to_sym  => goto_step || params[@step_parameter],
                :only_path  => true
               }.merge options
    url_for(options)
  end

  def update_wizard_path(goto_step = nil, options = {})
    wizard_path(goto_step, { :action => :update }.merge(options))
  end

end
