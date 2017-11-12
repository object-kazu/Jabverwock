# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jabverwock/version'

Gem::Specification.new do |spec|
  spec.name          = "jabverwock"
  spec.version       = Jabverwock::VERSION
  spec.authors       = ["kazuyuki shimizu"]
  spec.email         = ["kazuyukishimizu@me.com"]

  spec.summary       = %q{Jaberwock is attempt of integration with html, css and js}
  spec.description   = %q{I do not want to write html, css and js for making Web page}
  spec.homepage      = ""

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'opal', '>= 0.10.5'
  spec.add_dependency "paggio"
  spec.add_dependency "systemu"
  
  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"

    #privavte gem
  spec.add_dependency "test-unit"

end
