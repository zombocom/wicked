source "https://rubygems.org"

gemspec

# These are specified here instead of being development dependencies in the gemspec since they are platform dependent
# only at development time. There is no need for separate Ruby / JRuby versions of the gem, so this is better served
# by bundler in the Gemfile and in the gemspec.
group :development, :test do
  gem "sqlite3",                          :platform => [:ruby, :mswin, :mingw]
  gem "activerecord-jdbcsqlite3-adapter", '>= 1.3.0.beta', :platform => :jruby
end
