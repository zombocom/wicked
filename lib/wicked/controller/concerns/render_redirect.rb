module Wicked::Controller::Concerns::RenderRedirect
  extend ActiveSupport::Concern


  def render_wizard(resource = nil)
    process_resource!(resource)

    if @skip_to
      redirect_to wizard_path @skip_to
    else
      render_step @step
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

  def render_step(the_step)
    if the_step.nil? || the_step == :finish
      redirect_to_finish_wizard
    else
      render the_step
    end
  end

  def redirect_to_next(next_step)
    if next_step.nil?
      redirect_to_finish_wizard
    else
      redirect_to wizard_path(next_step)
    end
  end

  # TODO redirect to resource if one is passed to render_wizard
  def finish_wizard_path
    '/'
  end

  def redirect_to_finish_wizard
    redirect_to finish_wizard_path
  end

end
