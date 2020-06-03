module Wicked::Controller::Concerns::RenderRedirect
  extend ActiveSupport::Concern

  def render_wizard(resource = nil, options = {}, params = {})
    process_resource!(resource, options)

    if @skip_to
      url_params = (@wicked_redirect_params || {}).merge(params)
      redirect_to wizard_path(@skip_to, url_params), options
    else
      render_step(wizard_value(step), options, params)
    end
  end

  def process_resource!(resource, options = {})
    return unless resource

    if options[:context]
      did_save = resource.save(context: options[:context])
    else
      did_save = resource.save
    end

    if did_save
      @skip_to ||= @next_step
    else
      @skip_to = nil
      # Do not override user-provided status for render
      options[:status] ||= :unprocessable_entity
    end
  end

  def render_step(the_step, options = {}, params = {})
    if the_step.nil? || the_step.to_s == Wicked::FINISH_STEP
      redirect_to_finish_wizard options, params
    else
      render the_step, options
    end
  end

  def redirect_to_next(next_step, options = {}, params = {})
    if next_step.nil?
      redirect_to_finish_wizard(options, params)
    else
      redirect_to wizard_path(next_step, params), options
    end
  end

  # TODO redirect to resource if one is passed to render_wizard
  def finish_wizard_path(params = {})
    url = '/'
    url = "#{url}?#{params.to_query}" unless params.blank?
    url
  end

  def redirect_to_finish_wizard(options = {}, params = {})
    wicked_final_redirect_path = method(:finish_wizard_path).arity == 1 ? finish_wizard_path(params) : finish_wizard_path
    Rails.logger.debug("Wizard has finished, redirecting to finish_wizard_path: #{wicked_final_redirect_path.inspect}")
    # flash.keep is required for Rails 3 where a flash message is lost on a second redirect.
    flash.keep
    redirect_to wicked_final_redirect_path, options
  end
end
