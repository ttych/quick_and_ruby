# frozen_string_literal: true

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
  spec.homepage      = 'https://github.com/ttych/quick_and_ruby'
  spec.license       = 'MIT'

  spec.required_ruby_version = '> 2.6'

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'

    spec.metadata['homepage_uri'] = spec.homepage
    spec.metadata['source_code_uri'] = spec.homepage
    spec.metadata['changelog_uri'] = "#{spec.homepage}/CHANGELOG.md"
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
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^#{spec.bindir}/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bump', '~> 0.10.0'
  spec.add_development_dependency 'bundler', '~> 2.2', '>= 2.2.31'
  spec.add_development_dependency 'byebug', '~> 11.1', '>= 11.1.3'
  spec.add_development_dependency 'rake', '~> 13.0', '>= 13.0.6'
  spec.add_development_dependency 'reek', '~> 6.0', '>= 6.0.6'
  spec.add_development_dependency 'rspec', '~> 3.10'
  spec.add_development_dependency 'rubocop', '~> 1.22', '>= 1.22.3'
  spec.add_development_dependency 'rubocop-rake', '~> 0.6.0'
  spec.add_development_dependency 'rubocop-rspec', '~> 2.6'
end
