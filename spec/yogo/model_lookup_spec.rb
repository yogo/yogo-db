# encoding: utf-8
require File.join(File.dirname(__FILE__), '..', 'spec_helper')
require 'yogo/rack/model_lookup'

# Testing the middleware and how it modifies the environment
describe "Model lookup" do
  include Rack::Test::Methods

  def app
    setup_rack()
  end

  describe 'with an existing configuration' do

    before(:all) do
      @configuration = Factory.create(:schema)
    end

    after(:all) do
      @configuration.destroy
    end

    it "should add a yogo.resource key to the environment hash" do
      env = env_with_params("/schema/#{@configuration.name}")
      response = app.call(env)
      env.should be_a Hash
      env.should have_key('yogo.resource')
    end

    it "should add a yogo.schema key to the environment hash" do
      env = env_with_params("/schema/#{@configuration.name}")
      response = app().call(env)
      env.should be_a Hash
      env.should have_key('yogo.schema')
    end

    it "should point to a datamapper model" do
      env = env_with_params("/schema/#{@configuration.name}")
      response = app.call(env)
      env['yogo.resource'].should be_kind_of(DataMapper::Model)
    end

    it "should set a model when more then a path was specified" do
      env = env_with_params("/schema/#{@configuration.name}/more_path")
      response = app.call(env)
      env['yogo.resource'].should be_kind_of(DataMapper::Model)
    end
  end

  it "should not change the keys environment without a proper URI path" do
    env = env_with_params('/')
    lambda {
      app.call(env)
    }.should_not change(env, :keys)
  end


  it "should not set a model if no model id was specified" do
    env = env_with_params('/schema')
    lambda {
      app.call(env)
    }.should_not change(env, :keys)
  end

  it "should not set a model if a model id was specified but doesn't exist" do
    env = env_with_params('/schema/some%20sort%20of%20model')
    app.call(env)
    env['yogo.resource'].should be_nil
    env['yogo.schema'].should be_nil
  end

  # This test feels funny here.
  it "should respond with a 404 if a model id was specified but doesn't exist" do
    get '/schema/with_bad_id'
    last_response.should_not be_ok
    last_response.status.should eql(404)
  end
end
