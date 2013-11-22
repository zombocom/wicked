module Wicked::Controller::Concerns::RenderRedirect
  extend ActiveSupport::Concern


  def render_wizard(resource = nil, options = {})
    process_resource!(resource)

    if @skip_to
      redirect_to wizard_path(@skip_to), options
    else
      render_step wizard_value(step), options
    end
  end

  def process_resource!(resource)
    if resource
      if resource.save
        @skip_to ||= @next_step
      else
        @skip_to = nil
      end
    end
  end

  def render_step(the_step, options = {})
    if the_step.nil? || the_step.to_s == Wicked::FINISH_STEP
      redirect_to_finish_wizard options
    else
      render the_step, options
    end
  end

  def redirect_to_next(next_step, options = {})
    if next_step.nil?
      redirect_to_finish_wizard(options)
    else
      redirect_to wizard_path(next_step), options
    end
  end

  # TODO redirect to resource if one is passed to render_wizard
  def finish_wizard_path
    '/'
  end

  def redirect_to_finish_wizard(options = {})
    redirect_to finish_wizard_path, options
  end
end

