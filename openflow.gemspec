require File.expand_path("../lib/openflow/version", __FILE__)

Gem::Specification.new do |s|
  s.name          = "openflow"
  s.version       = OpenFlow::VERSION
  s.summary       = 'OpenFlow protocol and controller implementation in Ruby'
  s.description   = ''
  s.homepage      = 'http://github.com/simulacre/openflow'
  s.email         = 'openflow@simulacre.org'
  s.authors       = ['Caleb Crane']
  s.files         = Dir["lib/**/*.rb", "bin/*", "*.md", "LICENSE.txt"]
  s.require_paths = ["lib"]
  s.executables   = Dir["bin/*"].map{|p| p.split("bin/",2)[1] }

  s.add_dependency "bindata"
  s.add_development_dependency "rspec"
  s.add_development_dependency "rake"
  s.add_development_dependency "bundler"
end
