## This controller uses includes

class BarController < ApplicationController
  include Wicked::Wizard
  steps :first, :second, :last_step

  def show
    skip_step if params[:skip_step]
    jump_to :last_step if params[:jump_to]
    if params[:with_resource]
      render_wizard(Baz.new(params[:with_resource]))
    else
      render_wizard
    end
  end

  def update
  end
end
