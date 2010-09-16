# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/..' + '/spec_helper')

# Testing the middleware and how it modifies the environment
describe "Model lookup" do
    
  describe 'with an existing configuration' do
    
    before(:all) do
      @configuration = Schema.new(:name => 'sample_id')
      @configuration.operation('add/property', :id, 'Serial')
      @configuration.operation('add/property', :name, 'String')
      @configuration.save
    end
    
    after(:all) do
      @configuration.destroy
    end
    
    it "should add a yogo.resource key to the environment hash" do
      env = env_with_params('/schema/sample_id')
      response = setup_rack().call(env)
      env.should be_a Hash
      env.should have_key('yogo.resource')
    end

    it "should add a yogo.schema key to the environment hash" do
      env = env_with_params('/schema/sample_id')
      response = setup_rack().call(env)
      env.should be_a Hash
      env.should have_key('yogo.schema')
    end

    it "should point to a datamapper model" do
      env = env_with_params('/schema/sample_id')
      response = setup_rack.call(env)
      env['yogo.resource'].should be_kind_of(DataMapper::Model)
    end
    
    it "should set a model when more then a path was specified" do
      env = env_with_params('/schema/sample_id/more_path')
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
  
  it "should not set a model if a model id was specified but doesn't exist" do
    env = env_with_params('/schema/some%20sort%20of%20model')
    setup_rack.call(env)
    env['yogo.resource'].should be_nil
    env['yogo.schema'].should be_nil
  end
  
end
