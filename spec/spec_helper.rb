require 'rubygems'

begin
  require 'bundler'
  Bundler.setup
rescue LoadError
  puts "Bundler is not intalled. Install with: gem install bundler"
end

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'app'))

require 'yogo/model_lookup'
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

Rspec.configure do |config|
  config.include Yogo::Spec::Helpers
end
