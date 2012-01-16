# encoding: UTF-8
require 'rubygems'
require 'bundler'

begin
  Bundler.setup(:default, :development, :test)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'rake'
require 'rdoc/task'

require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end

task :default => :test

Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Wicked'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end


require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name        = "wicked"
  gem.homepage    = "http://github.com/schneems/wicked"
  gem.license     = "MIT"
  gem.summary     = %Q{Use Wicked to turn your controller into a wizard}
  gem.description = %Q{Wicked is a Rails engine for producing easy wizard controllers}
  gem.email       = "richard.schneeman@gmail.com"
  gem.authors     = ["schneems"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new


