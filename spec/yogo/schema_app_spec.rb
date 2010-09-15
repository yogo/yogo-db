# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/..' + '/spec_helper')

require 'yogo/schema_app'

# Testing potential endpoints
describe Yogo::SchemaApp do
  include Rack::Test::Methods
  
  def app
    setup_rack(Yogo::SchemaApp)
  end
  
  describe "when retrieving /schema" do
  
    it "should retrive a list of all schemas" do
      get '/schema', :headers => {'accepts' => 'application/json'}

      last_response.should be_ok
      last_response.headers['content-type'].should eql 'application/json'
    end
  end
  
  describe "when retriving /schema/:id" do
    it "should retrieve retrieve a particular schema"
    it "should give a 404 error when the schema does not exist"
  end
  
  describe "when posting to /schema" do
    it "should create a new schema with the provided id" 
    it "should not create a new schema with invalid data"
  end
  
  describe "when putting to /schema/:id" do
    it "should replace the schema with the given payload"
    it "should not update when given an invalid payload"
    it "should return an error when an invalid ID is given"
  end
  
  describe "when deleting /schema/:id" do
    it "should delete the schema of the given id"
    it "should not delete anything when an invalid ID is given" 
  end
end
