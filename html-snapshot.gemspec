require_relative 'lib/html_snapshot/version'

Gem::Specification.new do |spec|
  spec.name          = "html-snapshot"
  spec.version       = Html::Snapshot::VERSION
  spec.authors       = ["Thomas Cannon"]
  spec.email         = ["tcannon00@gmail.com"]

  spec.summary       = %q{A method for rendering HTML snippets as images}
  spec.description   = %q{A method for rendering HTML snippets as images}
  spec.homepage      = "https://github.com/cheerful/html-snapshot/"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/cheerful/html-snapshot/"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "sinatra"
  spec.add_dependency "puma"
  spec.add_dependency "terrapin"
end
