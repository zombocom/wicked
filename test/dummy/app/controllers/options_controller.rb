## This controller uses includes

class OptionsController < ApplicationController
  include Wicked::Wizard
  steps :first, :second, :only => :show

  def show
    render_wizard
  end

  def update
  end
end
