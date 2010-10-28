# encoding: utf-8
# Standard requirements for Bundler management
require 'rubygems'
require 'bundler/setup'

# Load the bundler gemset
Bundler.require(:default, ENV['RACK_ENV'] || :development )

# Mess with load paths
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))

# Configure DataMapper
require 'config/datamapper'

# Load Application pieces
require 'yogo/rack/model_lookup'
require 'yogo/schema_app'
require 'yogo/data_app'

# Load the Application Version
APP_VERSION = IO.readlines(File.join(File.dirname(__FILE__), 'VERSION'))[0]

# Make the model lookup map
use Yogo::Rack::ModelLookup, :paths => ['schema', 'data'], :scope => lambda{ |*args| return Schema }

# Run the app
run Rack::Cascade.new([Yogo::SchemaApp, Yogo::DataApp])
