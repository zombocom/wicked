module Wicked::Controller::Concerns::Path
  extend ActiveSupport::Concern


  def next_wizard_path
    wizard_path(@next_step)
  end

  def controller
    params[:controller]
  end

  def action
    params[:action]
  end


  def wizard_path(goto_step = nil, options = {})
    options = {
                 :controller => controller,
                 :action     => 'show',
                 :id         => goto_step || params[:id],
                 :only_path  => true
               }.merge options
    url_for(options)
  end
end
