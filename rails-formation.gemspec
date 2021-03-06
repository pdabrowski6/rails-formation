# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rails-formation/version'

Gem::Specification.new do |spec|
  spec.name          = 'rails-formation'
  spec.authors       = ['Paweł Dąbrowski']
  spec.email         = ['contact@paweldabrowski.com']
  spec.license       = 'MIT'
  spec.version       = RailsFormation::VERSION.dup

  spec.summary       = 'Templates for Rails bootstraping'
  spec.description   = spec.summary
  spec.homepage      = 'https://railsformation.com'
  spec.files         = Dir['CHANGELOG.md', 'LICENSE', 'README.md', 'rails-formation.gemspec', 'bin/*', 'lib/**/*',
                           'config/*.yml']
  spec.bindir        = 'bin'
  spec.executables   = ['formation']
  spec.require_paths = ['lib']

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  spec.metadata['changelog_uri']     = 'https://github.com/pdabrowski6/rails-formation/blob/master/CHANGELOG.md'
  spec.metadata['source_code_uri']   = 'https://github.com/pdabrowski6/rails-formation'
  spec.metadata['bug_tracker_uri']   = 'https://github.com/pdabrowski6/rails-formation/issues'
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.required_ruby_version = '>= 2.7.0'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'timecop'
end
