class WickedRailtie < Rails::Railtie
  initializer 'wicked' do
    # TODO, remove when support for rails 3.x is dropped
    if Rails::VERSION::MAJOR < 4
      ActionController::Base.class_eval do
        alias_method :before_action, :before_filter
        alias_method :prepend_before_action, :prepend_before_filter
        alias_method :skip_before_action, :skip_before_filter
      end
    end
  end
end
