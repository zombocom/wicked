class UpdatesController < ApplicationController
  include Wicked::Wizard

  class Thing
    def save
      true
    end
  end

  steps :first, :second, :last_step

  def index

  end

  def show
    render_wizard
  end

  def update
    @thing = Thing.new
    render_wizard(@thing, notice: "Thing was updated from step #{step}.")
  end

  private

  def finish_wizard_path
    updates_path
  end
end
