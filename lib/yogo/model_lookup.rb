# encoding: utf-8
require 'dm-core'

module Yogo
  class ModelLookup
    def initialize(app, options = {})
      paths = options[:paths] || ['data']
      
      @app = app
      @base_regexp = /^\/(#{paths.join('|')})\/(([a-zA-Z0-9]|-|_)+)/
    end

    def call(env)
      if env['PATH_INFO'] =~ @base_regexp
        model_id = $2
        env['yogo.resource'] = get_model(model_id)
      end
      
      @app.call(env)

    end

    private
    
    def get_model(env)
      ::DataMapper::Model.new
    end

  end
end