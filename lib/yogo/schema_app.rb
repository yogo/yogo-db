require 'sinatra'

module Yogo
  class SchemaApp < ::Sinatra::Base
    before do
      content_type :json
    end

    get '/schema/?' do
      { :content => Schema.all.to_json(:to_json => false) }.to_json
    end

    get '/schema/:model_id/?' do
      { :content => env['yogo.schema'] }.to_json
    end

    post '/schema' do
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