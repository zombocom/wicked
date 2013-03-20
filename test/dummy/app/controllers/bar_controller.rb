## This controller uses includes

class BarController < ApplicationController
  include Wicked::Wizard
  steps :first, :second, :last_step

  def show
    skip_step if params[:skip_step]
    flash[:notice] = params[:notice] if params[:notice]
    render_wizard
  end

  def update
  end
end
