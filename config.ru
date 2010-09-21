# require 'rubygems'
# require 'bundler/setup'
# 
# Bundler.require(:default, ENV['RACK_ENV'])
# 
# $:.unshift File.dirname(__FILE__)
# 
# require 'lib/yogo/model_lookup'
# 
# require 'app/yogo/schema_app'

require './config/requires'

use Yogo::Rack::ModelLookup, :paths => ['schema', 'data']

use Yogo::SchemaApp
run Sinatra::Base
