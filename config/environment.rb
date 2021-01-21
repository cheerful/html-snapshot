require 'bundler/setup'
require 'yaml'

APP_ENV = ENV["RACK_ENV"] || "development"

Bundler.require :default, APP_ENV.to_sym

set :app_file, "app.rb"

def load_env_file(environment = nil)
  root_directory = Pathname.new(Sinatra::Application.root)
  path = root_directory.join("config", "env#{environment.nil? ? '' : '.'+environment.to_s}.yml")
  return unless File.exist? path
  config = YAML.load(ERB.new(File.new(path).read).result)
  config.each { |key, value| ENV[key.to_s] = value.to_s }
end

# Load environment variables. config/env.yml contains defaults which are
# suitable for development. (This file is optional).
load_env_file

# Now look for custom environment variables, stored in env.[environment].yml
# For development, this file is not checked into source control, so feel
# free to tweak for your local development setup. Any values defined here
# overwrite the defaults in `env.yml`
load_env_file(Sinatra::Application.environment)