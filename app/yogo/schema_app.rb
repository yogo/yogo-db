require 'sinatra'
# require 'json'

module Yogo
  class SchemaApp < ::Sinatra::Base
  
    # configure(:development) do
    #   register ::Sinatra::Reloader
    #   also_reload "app/models/*.rb"
    #   # dont_reload "lib/**/*.rb"
    # end
  
    before do
      content_type :json
    end
  
    get '/schema/?' do
      Schema.all.to_json
    end
  
    get '/schema/:model_id/?' do
      env['yogo.schema'].to_json
    end
  
    post '/schema' do
      opts = Schema.parse_json(request.body.read) rescue nil
      halt(401, 'Invalid Format') if opts.nil?
      schema = Schema.new(opts)

      halt(500, 'Could not save schema') unless schema.save

      response['Location'] = "/schema/#{schema.name}"
      response.status = 201
    end
    
    put '/schema/:model_id' do
      'OK'.to_json
    end
    
    delete '/schema/:model_id' do
      if env['yogo.schema'].destroy
        'OK'.to_json
      else
        'FAIL'.to_json
      end
    end
  
  end
end