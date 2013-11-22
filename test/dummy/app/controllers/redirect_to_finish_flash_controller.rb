class RedirectToFinishFlashController < ApplicationController
  include Wicked::Wizard

  steps :first, :second, :last_step

  def index

  end

  def show
    render_wizard
  end

  def update
    render_wizard(nil, notice: 'Flash message notice')
  end

  def finish_wizard_path
    redirect_to_finish_flash_index_path
  end

end
