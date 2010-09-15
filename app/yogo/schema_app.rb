require 'sinatra'
require 'json'

module Yogo
  class SchemaApp < ::Sinatra::Base
  
    before do
      content_type :json
    end
  
    get '/schema/?' do
      "Hello World".to_json
    end
  
    get '/schema/:model_id' do
      "#{params[:model_id]}".to_json
    end
  
  end
end