## This controller sends a return_wizard with a block to be executed 
## if the resource was saved successfully 

class RenderWithBlockController < ApplicationController
  include Wicked::Wizard
  steps :first, :second, :last_step

  def show
    render_wizard
  end

  def update
    @bar = Bar.new(true)
    render_wizard(@bar) { puts("Success") }
  end
end

