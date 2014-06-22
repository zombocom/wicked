## This controller uses includes

class Nested::BuilderController < ApplicationController
  include Wicked::Wizard

  primary_resource :nested
  steps :first, :second, :last_step

  # nested_builder GET    /nested/:nested_id/builder/:id(.:format)      {:action=>"show", :controller=>"builder"}
  def show
    raise "no nested_id: #{params.inspect}" unless params[:nested_id].present?
    raise "no id: #{params.inspect}"        unless params[:id].present?

    render_wizard
  end

  def update
    if step == :first
      @nested = Nested.new
      render_wizard(@nested)
    end
  end
end
