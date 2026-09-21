source "https://rubygems.org"

gemspec

group :development, :test do
  # ActiveRecord <= 7.0's sqlite3 adapter requires sqlite3 ~> 1.4, so hold
  # it there for every appraisal (7.1+ accepts >= 1.4)
  gem "sqlite3", "~> 1.4", :platform => [:ruby, :mswin, :mingw]
  gem "activerecord-jdbcsqlite3-adapter", '~> 1.3.13', :platform => :jruby
end
