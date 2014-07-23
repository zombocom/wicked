## This controller uses includes

class BarController < ApplicationController
  include Wicked::Wizard
  steps :first, :second, :last_step

  def show
    skip_step if params[:skip_step]
    flash[:notice] = params[:notice] if params[:notice]
    if params[:resource]
      value = params[:resource][:save] == 'true'
      @bar  = Bar.new(value)
      params.delete(:resource)
      render_wizard(@bar, params)
    else
      render_wizard
    end
  end

  def update
  end
end
