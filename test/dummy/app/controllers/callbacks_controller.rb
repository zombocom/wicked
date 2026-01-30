class CallbacksController < ApplicationController
  include Wicked::Wizard

  class CallbackCounter
    @@count = 0

    def self.increment
      @@count += 1
    end

    def self.count
      @@count
    end

    def self.reset
      @@count = 0
    end
  end

  steps :success_step, :failure_step

  def show
    render_wizard
  end

  def update
    value = case step
            when :success_step
              true
            when :failure_step
              false
            end

    @bar = Bar.new(value)

    render_wizard(@bar) do
      CallbackCounter.increment
    end
  end

  private

  def finish_wizard_path
    root_path
  end
end
