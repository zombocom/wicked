source "https://rubygems.org"

rails_version = ENV["RAILS_VERSION"] || "default"

rails = case rails_version
when "master"
  {:github => "rails/rails"}
when "default"
  ">= 3.0.7"
else
  "~> #{rails_version}"
end

gem "rails", rails


group :development, :test do
  gem 'rake'
  gem 'jeweler'
  gem "capybara", "~> 1.1.2"
  gem "launchy"

  gem "sqlite3",                          :platform => [:ruby, :mswin, :mingw]
  gem "activerecord-jdbcsqlite3-adapter", '>= 1.3.0.beta', :platform => :jruby
end
