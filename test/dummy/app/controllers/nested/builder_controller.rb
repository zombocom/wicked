## This controller uses includes

class Nested::BuilderController < ApplicationController
  include Wicked::Wizard

  steps :first, :second, :last_step

  # nested_builder GET    /nested/:nested_id/builder/:id(.:format)      {:action=>"show", :controller=>"builder"}
  def show
    raise "no nested_id" unless params[:nested_id].present?
    raise "no id"        unless params[:id].present?
    render_wizard
  end

  def update
  end
end
