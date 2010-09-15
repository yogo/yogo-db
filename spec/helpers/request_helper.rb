# encoding: utf-8

require 'yogo/model_lookup'

# This is inspired by Warden's spec helpers
module Yogo
  module Spec
    module Helpers
    
      def env_with_params(path = "/", params = {})
        method = params.fetch(:method, "GET")
        Rack::MockRequest.env_for(path, :input => Rack::Utils.build_query(params),
                                        'HTTP_VERSION' => '1.1',
                                        'REQUEST_METHOD' => "#{method}")
      end
    
      def setup_rack(app = default_app, middleware = {}, &block)
        app ||= block if block_given?
      
        Rack::Builder.new do
          use Yogo::ModelLookup, :paths => ['schema']
          run app
        end
      
      end
    
      def default_app
        lambda { |env| [ 200, {'Content-Type' => 'text/plain'}, ["Hello World"]]}
      end
    end
  end
end