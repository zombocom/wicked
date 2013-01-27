class I18nController < ApplicationController
  include Wicked::Wizard::Translated

  steps :first, :second, :last_step

  def show
    render_wizard
  end

  def update
  end

end
