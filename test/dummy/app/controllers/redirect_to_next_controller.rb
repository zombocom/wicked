class RedirectToNextController < ApplicationController
  include Wicked::Wizard
  steps :first, :second, :last_step

  def show
    if params[:jump_to]
      if params[:jump_to] == 'finish_wizard'
        redirect_to_finish_wizard :notice => params[:notice]
      else
        redirect_to_next params[:jump_to], :notice => params[:notice]
      end
    else
      render_wizard
    end
  end

  def update
  end

end