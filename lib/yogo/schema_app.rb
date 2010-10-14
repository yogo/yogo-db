require 'sinatra'

module Yogo
  class SchemaApp < ::Sinatra::Base
    set :haml, { :format => :html5 }
    set :views, File.dirname(__FILE__) + '/views'
    
    # before do
    #   content_type :json
    # end
    # 
    configure(:development) do
      register Sinatra::Reloader
      # also_reload "app/models/*.rb"
      # dont_relo
      # ad "lib/**/*.rb"
    end
    

    get '/schema/?' do
      types = Sinatra::Request.new(env).accept()
      if types.include?('application/json')
         content_type :json
        { :content => Schema.all.to_json(:to_json => false) }.to_json
      else
        @schemas = Schema.all
        haml :'schema/index.html'
      end
    end

    get '/schema/:model_id/?' do
      types = Sinatra::Request.new(env).accept()
      if types.include?('application/json')
        content_type :json
        { :content => env['yogo.schema'] }.to_json        
      else
        @schema = env['yogo.schema']
        haml :'schema/show.html'
      end
    end

    post '/schema/?' do
      opts = Schema.parse_json(request.body.read) rescue nil
      halt(401, 'Invalid Format') if opts.nil?
      schema = Schema.new(opts)

      halt(500, 'Could not save schema') unless schema.save

      response['Location'] = schema.to_url
      response.status = 201
    end

    put '/schema/:model_id' do
      schema = env['yogo.schema']
      opts = Schema.parse_json(request.body.read) rescue nil
      halt(401, 'Invalid Format') if opts.nil?

      halt(500, 'Could not update schema') unless schema.update(opts)

      { :content => schema }.to_json
    end

    delete '/schema/:model_id' do
      env['yogo.schema'].destroy
    end

  end
end