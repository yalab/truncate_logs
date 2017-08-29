# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "truncate_logs/version"

Gem::Specification.new do |spec|
  spec.name          = "truncate_logs"
  spec.version       = TruncateLogs::VERSION
  spec.authors       = ["yalab"]
  spec.email         = ["rudeboyjet@gmail.com"]

  spec.summary       = %q{Truncate logs for too large params or fixtures.}
  spec.description   = %q{If you use binary data post or so. Your log file is soon too large. This gem provides truncate too large params or fixutre loggings.}
  spec.homepage      = "https://github.com/yalab/truncate_logs"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
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

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_dependency "actionpack", "~>5.0"
  spec.add_dependency "activesupport", "~>5.0"
  spec.add_development_dependency "activerecord", "~> 5.0"
  spec.add_development_dependency "sqlite3"
end
