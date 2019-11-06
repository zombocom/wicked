class SpecificTemplateController < ApplicationController
  include Wicked::Wizard

  class Steps
    RANDOM_RANGE = [('Random Step A'..'Random Step Z')].flat_map(&:to_a).map(&:underscore)

    def self.random
      $random_steps ||= RANDOM_RANGE.sample(rand(1..5))
    end

    def self.fix
      ['first', 'second', 'last_step'].map(&:underscore)
    end
  end

  prepend_before_action :set_steps

  def show
    if params[:id].in?(Steps.fix)
      render_wizard
    else
      @dynamic_random_step = Steps::RANDOM_RANGE.find { |s| s == params[:id] }
      render_wizard(nil, template: :main)
    end
  end

  private

    def set_steps
      _steps_ = Steps.random
      _steps_ += Steps.fix
      self.steps = _steps_
    end
end