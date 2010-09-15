# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/..' + '/spec_helper')

# Testing the middleware and how it modifies the environment
describe "Schema Middleware" do
    
  describe 'yogo.resource' do
    
    it "should be a key in the environment hash" do
      env = env_with_params('/schema/some_id')
      response = setup_rack().call(env)
      env.should be_a Hash
      env.should have_key('yogo.resource')
    end

    it "should point to a datamapper model" do
      env = env_with_params('/schema/some_id')
      response = setup_rack.call(env)
      env['yogo.resource'].should be_kind_of(DataMapper::Model)
    end
  end

  it "should not change the keys environment without a proper URI path" do
    env = env_with_params('/')
    lambda {
      setup_rack.call(env)
    }.should_not change(env, :keys)
  end
  
  
  it "should not set a model if no model id was specified" do
    env = env_with_params('/schema')
    lambda {
      setup_rack.call(env)
    }.should_not change(env, :keys)
  end
  
  it "should set a model when more then a path was specified" do
    env = env_with_params('/schema/model_id/more_path')
    response = setup_rack.call(env)
    env['yogo.resource'].should be_kind_of(DataMapper::Model)
  end
  
end
