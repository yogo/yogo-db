# encoding: utf-8
require 'rubygems'
require 'bundler/setup'

Bundler.require(:default, ENV['RACK_ENV'] || :development )

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'app'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'app', 'model'))


require './config/datamapper'
require 'yogo/rack/model_lookup'
require 'yogo/schema_app'
