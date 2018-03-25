
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "trollme/version"

Gem::Specification.new do |spec|
  spec.name          = "trollme"
  spec.version       = Trollme::VERSION
  spec.authors       = ["Ruffeng"]
  spec.email         = ["ruffeng@gmail.com"]
  spec.homepage      = 'https://github.com/Ruffeng/trollme/tree/master'
  spec.summary       = %q{Gem to troll your colleagues from the office.}
  spec.description   = %q{This gem let's you change the desktop background from your colleagues. Perfect for trolling those who left the computer unlocked. Check the homepage to know how to use it}
  spec.license       = "MIT"

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir = 'exe'
  spec.executables = 'trollme'
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'fakefs', '~> 0.13'
  spec.add_development_dependency 'pry', '~> 0.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
