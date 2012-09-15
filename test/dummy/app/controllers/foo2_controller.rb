## This controller uses inheritance

class Foo2Controller < Wicked::WizardController
  steps :first, :second, :last_step

  def edit
    skip_step if params[:skip_step]
    render_wizard
  end

  def update
  end
end
