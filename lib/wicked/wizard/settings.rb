module Wicked
  module Wizard
    module Settings
      extend ActiveSupport::Concern
      
      included do
        define_singleton_method :use_wizard_index do
          :wizard_index
        end
         
        define_singleton_method :use_wizard_show do
          :wizard_show
        end
      end
      
    end
  end
end

