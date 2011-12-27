# Please don't re-use any patterns found in this controller,
# they work, but are not very good practices.
# If you have a better way to do this, please let me know

class Wicked::WizardController < ApplicationController
  include Wicked::Controller::Concerns::Path
  include Wicked::Controller::Concerns::RenderRedirect
  include Wicked::Controller::Concerns::Steps


  helper_method :wizard_path, :next_wizard_path

  before_filter :setup_wizard

  def index
    # redirect_to_first_step
  end

  # steps :confirm_password, :invite_fb

  # @example show action
  # def show
  #   case step
  #   when :confirm_password
  #     redirect_to_next(@next_step) and return nil unless @user.facebook?
  #   when :invite_fb
  #     redirect_to_next(@next_step) and return nil unless @user.facebook?
  #   end
  #   render_wizard
  # end


  # @example update action
  # def update
  #   case step
  #   when :confirm_password
  #     @user.update_attributes(params[:user])
  #   when :confirm_profile
  #     @user.update_attributes(params[:user])
  #   end
  #   sign_in(@user, :bypass => true) # needed for devise
  #   render_wizard
  # end

  private


  def setup_wizard
    @step      = params[:id].try(:to_sym) || steps.first
    @next_step = next_step(@step)
  end

end

module Wicked
  Wizard = Wicked::WizardController
end
