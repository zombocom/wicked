class StatusCodesController < ApplicationController
  include Wicked::Wizard

  class GoodThing
    def save
      true
    end
  end

  class BadThing
    def save
      false
    end
  end

  steps :good, :bad

  def index; end

  def show
    render_wizard
  end

  def update
    case step
    when :good
      @thing = GoodThing.new
    when :bad
      @thing = BadThing.new
    end
    render_wizard(@thing, notice: "Thing was updated from step #{step}.")
  end

  private

  def finish_wizard_path
    updates_path
  end
end
