require "bundler/setup"
require 'dotenv/load'
require 'html_snapshot'

run HTMLSnapshot::Server.new(headless_browser_path: ENV.fetch('HEADLESS_BROWSER_PATH'))