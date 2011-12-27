# Provide a simple gemspec so you can easily use your enginex
# project in your rails apps through git.

Gem::Specification.new do |s|
  s.name        = "wicked"
  s.summary     = "Use Wicked to turn your controller into a wizard"
  s.description = "Wicked is a Rails engine for producing easy wizard controllers"
  s.homepage    = 'http://github.com/schneems/wicked'
  s.authors     = ['Richard Schneeman']
  s.email       = ['richard.schneeman@gmail.com']


  s.required_rubygems_version = "> 1.3.6"



  s.add_dependency "activesupport" , ">= 3.0.7"

  s.add_dependency "rails"         , ">= 3.0.7"

  s.files = Dir["{app,lib,config}/**/*"] + ["MIT-LICENSE", "Rakefile", "Gemfile", "README.md"]
  s.version = "0.0.1"
  s.executables = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'

end