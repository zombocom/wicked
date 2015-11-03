class SettingsController < ApplicationController
  include Wicked::Wizard::Settings
  
  
  include Wicked::Wizard
  steps :first, :second, :last_step
  

  
  def index
    
  end
  
  def show
    render :text => 'myshow'
  end

end