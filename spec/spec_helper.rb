ENV["RACK_ENV"] ||= 'test'

# require 'rubygems'
# 
# begin
#   require 'bundler'
#   Bundler.setup
# rescue LoadError
#   puts "Bundler is not intalled. Install with: gem install bundler"
# end
# 
# $LOAD_PATH.unshift(File.dirname(__FILE__))
# $LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require './config/requires'
require 'rspec/core'
require 'autotest/rspec2'
require 'rack/test'
require 'rack/mock'

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
  # 
  config.before(:all) { DataMapper.auto_migrate! }
end
