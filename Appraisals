appraise "rails-5.2" do
  gem "rails", "~> 5.2.0"
end

appraise "rails-6.0" do
  gem "rails", "~> 6.0.0"
  # concurrent-ruby 1.3.5 removed its `require "logger"`, which breaks
  # ActiveSupport < 7.1 with `uninitialized constant Logger`
  gem "concurrent-ruby", "< 1.3.5"
end

appraise "rails-7.0" do
  gem "rails", "~> 7.0.0"
end

appraise "rails-7.1" do
  gem "rails", "~> 7.1.0"
end
