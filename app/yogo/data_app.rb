require 'sinatra'
# require 'json'

module Yogo
  class DataApp < ::Sinatra::Base
  
    # configure(:development) do
    #   register ::Sinatra::Reloader
    #   also_reload "app/models/*.rb"
    #   # dont_reload "lib/**/*.rb"
    # end
  
    before do
      content_type :json
    end

    # I don't think this should return anything.
    # get '/data/?' do
    #   { :content => Schema.all }.to_json
    # end
  
    get '/data/:model_id/?' do
      { :content => env['yogo.resource'].all }.to_json
    end
  
    get '/data/:model_id/:id' do
      resource = env['yogo.resource']
      item = resource.get(params[:id])
      
      { :content => item }.to_json
    end
  
    post '/data/:model_id' do
      resource = env['yogo.resource']
      opts     = resource.parse_json(request.body.read) rescue nil
      
      halt(401, 'Invalid Format') if opts.nil?
      
      item = resource.new(opts)

      halt(500, 'Could not save item') unless item.save

      response['Location'] = item.to_url
      response.status = 201
    end
    
    put '/schema/:model_id/:id' do
      resource = env['yogo.resource']
      item     = resource.get(params[:id])
      opts     = resource.parse_json(request.body.read) rescue nil
      halt(401, 'Invalid Format') if opts.nil?
      
      halt(500, 'Could not update schema') unless item.update(opts)

      { :content => item }.to_json
    end
    
    delete '/schema/:model_id/:id' do
      env['yogo.resource'].get(params[:id]).destroy
    end
  
  end
end