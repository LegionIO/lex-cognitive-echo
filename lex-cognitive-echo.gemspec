# frozen_string_literal: true

require_relative 'lib/legion/extensions/cognitive_echo/version'

Gem::Specification.new do |spec|
  spec.name          = 'lex-cognitive-echo'
  spec.version       = Legion::Extensions::CognitiveEcho::VERSION
  spec.authors       = ['Esity']
  spec.email         = ['matthewdiverson@gmail.com']

  spec.summary       = 'Thought echo and residual activation tracking for LegionIO'
  spec.description   = 'Models residual cognitive activation from previous processing. Recent thoughts ' \
                       'leave echoes that decay over time but influence current processing through ' \
                       'priming and interference effects.'
  spec.homepage      = 'https://github.com/LegionIO/lex-cognitive-echo'
  spec.license       = 'MIT'

  spec.required_ruby_version = '>= 3.4'

  spec.metadata['homepage_uri']          = spec.homepage
  spec.metadata['source_code_uri']       = 'https://github.com/LegionIO/lex-cognitive-echo'
  spec.metadata['documentation_uri']     = 'https://github.com/LegionIO/lex-cognitive-echo/blob/master/README.md'
  spec.metadata['changelog_uri']         = 'https://github.com/LegionIO/lex-cognitive-echo/blob/master/CHANGELOG.md'
  spec.metadata['bug_tracker_uri']       = 'https://github.com/LegionIO/lex-cognitive-echo/issues'
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.require_paths = ['lib']
end
