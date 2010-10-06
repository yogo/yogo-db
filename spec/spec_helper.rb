# Standard requirements for Bundler management
require 'rubygems'
require 'bundler/setup'

# Load the bundler gemset
Bundler.require(:default, ENV['RACK_ENV'] || :test )

# Mess with load paths
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rspec/core'
require 'autotest/rspec2'
require 'rack/test'
require 'rack/mock'

require 'config/datamapper'

begin
  require 'ruby-debug'
rescue Exception => e
  puts "ruby-debug is not installed. Install it with 'gem install ruby-debug'"
end

Dir[File.join(File.dirname(__FILE__), "helpers", "**/*.rb")].each do |f|
  require f
end

Dir[File.join(File.dirname(__FILE__), "factories", "**/*.rb")].each do |f|
  require f
end

Rspec.configure do |config|
  config.include Yogo::Spec::Helpers
  # config.mock_with :rspec
  config.before(:all) { DataMapper.finalize.auto_migrate! }
end
