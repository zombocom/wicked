module Wicked::Controller::Concerns::Path
  extend ActiveSupport::Concern


  def next_wizard_path
    wizard_path(@next_step)
  end

  def current_url
    request.url
  end

  def current_uri
    URI.parse(current_url)
  end

  def base_uri
    "#{current_uri.scheme}://#{current_uri.host}"
  end

  def current_path
    current_uri.pat
  end

  def current_path_array
    current_uri.path.split('/')
  end


  def wizard_path(goto_step = nil)
    path_array = current_path_array
    if goto_step.present?
      path_array.pop if steps.map(&:to_sym).include? path_array.last.to_sym
      path_array << goto_step.to_s
    end
    File.join('/', *path_array)
  end
end
