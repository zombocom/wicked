## This controller uses includes

class Bar2Controller < ApplicationController
  include Wicked::Wizard
  steps :first, :second, :last_step

  def edit
    skip_step if params[:skip_step]
    render_wizard
  end

  def update
  end
end
