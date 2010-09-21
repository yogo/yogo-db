# encoding: utf-8
require 'dm-core'
require 'model/schema'

module Yogo
  module Rack
    class ModelLookup
      def initialize(app, options = {})
        paths = options[:paths] || ['data']
        @app = app
        @base_regexp = /^\/(#{paths.join('|')})\/(([a-zA-Z0-9]|-|_)+)/
      end

      def call(env)
        if env['PATH_INFO'] =~ @base_regexp
          model_id = $2
          env['yogo.schema'], env['yogo.resource'] = get_model(model_id)
          return [ 404, {'Content-Type' => 'text/plain'}, ["#{model_id} not found"] ] if env['yogo.schema'].nil?
        end
        
        @app.call(env)
      end

      private
  
      def get_model(model_id)
        config = Schema.first(:name => model_id)
    
        unless config.nil?
          return config, config.data_model
        end
      end
      
    end # ModelLookup
  end # Rack
end # Yogo
