require 'rubygems'

begin
  require 'bundler'
  Bundler.setup
rescue LoadError
  puts "Bundler is not intalled. Install with: gem install bundler"
end

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'yogo/db'
require 'spec'
require 'spec/autorun'
require 'rack/test'
require 'rack/mock'

begin
  require 'ruby-debug'
rescue Exception => e
  puts "ruby-debug is not installed. Install it with 'gem install ruby-debug'"
end


Spec::Runner.configure do |config|
  config.include Rack::Test::Methods
end
