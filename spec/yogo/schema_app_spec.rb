# encoding: utf-8
require File.join(File.dirname(__FILE__), '..', 'spec_helper')
require 'yogo/schema_app'

# Testing potential endpoints
describe Yogo::SchemaApp do
  include Rack::Test::Methods

  def app
    setup_rack(Yogo::SchemaApp)
  end

  describe "when retrieving /schema" do

    it "should retrive a list of all schemas" do
      header 'accept', 'application/json'
      get '/schema'

      last_response.should be_ok
      last_response.headers['content-type'].should eql 'application/json'
    end
  end

  describe "when retriving /schema/:id" do
    it "should retrieve retrieve a particular schema" do
      schema = Factory.create(:schema)
      header 'accept', 'application/json'
      get "/schema/#{schema.name}"
      last_response.should be_ok
      last_response.body.should eql( { :content => schema }.to_json )
    end

    it "should give a 404 error when the schema does not exist" do
      get '/schema/with_bad_id'
      last_response.should_not be_ok
      last_response.status.should eql(404)
    end
  end

  describe "when posting to /schema" do
    it "should create a new schema with the provided id" do
      post '/schema', {:name => 'test_item',
        :operations => [['add/property', :id, 'Serial'],['add/property', :name, 'String']]}.to_json

      last_response.status.should eql(201)

      get '/schema/test_item'
      last_response.should be_ok
    end

    it "should not create a new schema with invalid data" do
      post '/schema', {:name => 'test_item',
        :bad_op => 42}.to_json

      last_response.status.should eql(401)
      last_response.body.should eql("Invalid Format")
    end
  end

  describe "when putting to /schema/:id" do
    before(:all) do
      @cur_schema = Factory.create(:schema)
    end

    after(:all) do
      @cur_schema.destroy
    end

    it "should replace the schema with the given payload" do
      updated_schema = {'name' => @cur_schema.name,
        'operations' => [['add/property', 'id', 'Integer'],['add/property', 'description', 'Text'] ]}
      put "/schema/#{@cur_schema.name}", updated_schema.to_json

      last_response.status.should eql(200)
      JSON.parse(last_response.body)["content"].should eql updated_schema.merge('guid' => "/schema/#{@cur_schema.name}")
    end

    it "should not update when given an invalid payload" do
      put "/schema/#{@cur_schema.name}", "some really bad data"

      last_response.should_not be_ok
    end
    it "should return an error when an invalid ID is given" do
      put '/schema/a_bad_id', "not so good data"

      last_response.should_not be_ok
      last_response.status.should eql(404)
    end
  end

  describe "when deleting /schema/:id" do
    it "should delete the schema of the given id" do
      schema = Factory.create(:schema)
      delete "/schema/#{schema.name}"

      last_response.should be_ok
    end
    it "should not delete anything when an invalid ID is given" do
      delete "/schema/a_bad_id"

      last_response.should_not be_ok
      last_response.status.should eql 404
    end
  end
end
