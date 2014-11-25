source "https://rubygems.org"


# Put all runtime dependencies in wicked.gemspec
# Put development requirements for different platforms here
# Put more specific gem declarations in different gemfiles/*.gemfile files
gemspec :path => File.expand_path("../.", __FILE__)

group :development, :test do
  gem "sqlite3", :platform => [:ruby, :mswin, :mingw]
  gem "activerecord-jdbcsqlite3-adapter", '~> 1.3.13', :platform => :jruby
end
