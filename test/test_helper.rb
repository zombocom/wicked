# Configure Rails Envinronment
ENV["RAILS_ENV"] = "test"

ENGINE_RAILS_ROOT=File.join(File.dirname(__FILE__), '../')
require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"

ActionMailer::Base.delivery_method = :test
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.default_url_options[:host] = "test.com"

Rails.backtrace_cleaner.remove_silencers!

# Configure capybara for integration testing
require "capybara/rails"
Capybara.default_driver   = :rack_test
Capybara.default_selector = :css

# https://github.com/plataformatec/devise/blob/master/test/orm/active_record.rb
migrate_path = File.expand_path("../rails_app/db/migrate", __FILE__)
if ActiveRecord.version < Gem::Version.create("5.2.0")
  ActiveRecord::Migrator.migrate(migrate_path)
elsif ActiveRecord.version < Gem::Version.create("6.0.0")
  ActiveRecord::MigrationContext.new(migrate_path).migrate
else
  ActiveRecord::MigrationContext.new(migrate_path, ActiveRecord::SchemaMigration).migrate
end

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

class ActiveSupport::IntegrationCase
  def assert_has_content?(content)
    assert has_content?(content), "Expected #{page.body} to include #{content.inspect}"
  end
end
