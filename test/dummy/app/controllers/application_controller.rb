class ApplicationController < ActionController::Base
  protect_from_forgery
  if respond_to? :before_action
    before_action :pull_out_locale
  else
    before_filter :pull_out_locale
  end

  def pull_out_locale
    I18n.locale = params[:locale] if params[:locale].present?
  end
end
