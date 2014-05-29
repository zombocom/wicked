class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :pull_out_locale


  def pull_out_locale
    I18n.locale = params[:locale] if params[:locale].present?
  end
end
