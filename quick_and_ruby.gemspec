lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'quick_and_ruby/version'

Gem::Specification.new do |spec|
  spec.name          = 'quick_and_ruby'
  spec.version       = QuickAndRuby::VERSION
  spec.authors       = ['ttych']
  spec.email         = ['thomas.tych@gmail.com']

  spec.summary       = 'Quick and Ruby utilities.'
  spec.description   = 'Set of small and standalone utilities in Ruby.'
  spec.homepage      = 'https://github.com/ttych/quick-and-ruby'
  spec.license       = 'MIT'

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'http://mygemserver.com'

    spec.metadata['homepage_uri'] = spec.homepage
    spec.metadata['source_code_uri'] = 'https://github.com/ttych/quick_and_ruby'
    spec.metadata['changelog_uri'] = 'https://github.com/ttych/quick_and_ruby'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem
  # that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.66.0'
end
