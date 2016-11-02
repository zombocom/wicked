class UpdateParamsController < ApplicationController
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
    render_wizard(nil, {}, { one: 'two' })
  end

  def update
    @thing = Thing.new
    render_wizard(@thing, { notice: "Thing was updated from step #{step}." }, { one: 'two' })
  end

  private

  def finish_wizard_path(params)
    update_params_path(params)
  end
end
