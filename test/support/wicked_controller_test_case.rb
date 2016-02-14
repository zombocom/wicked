class WickedControllerTestCase < ActionController::TestCase
  if ActionPack::VERSION::MAJOR < 5
    %w{get post put update}.each do |meth|
      define_method meth do |action, args={}|
        super(action, args[:params], args[:session], args[:flash])
      end
    end
  end
end