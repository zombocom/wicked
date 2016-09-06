gem "rack", "< 2" if Gem::Version.new(RUBY_VERSION) < Gem::Version.new("2.2")
gem 'mime-types', '< 3', require: false if RUBY_VERSION.start_with?('1.9')

appraise "3.1" do
  gem "rails", "~> 3.1.0"
  gemspec
end

appraise "3.2" do
  gem "rails", "~> 3.2.15"
  gemspec
end

appraise "4.0" do
  gem "rails", "~> 4.0.0"
  gemspec
end

appraise "4.1" do
  gem "rails", "~> 4.1.0"
  gemspec
end


appraise "4.2" do
  gem "rails", "~> 4.2"
  gemspec
end

appraise "5.0.beta2" do
  gem "rails", "~> 5.0.0.beta2"
  gemspec
end
