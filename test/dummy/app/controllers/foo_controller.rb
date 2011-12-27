class FooController < Wicked::WizardController
  steps :first, :second

  def show
    skip_step if params[:skip_step]
    render_wizard
  end

  def update
  end
end
