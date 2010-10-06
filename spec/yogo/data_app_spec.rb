# encoding: utf-8
require File.join(File.dirname(__FILE__), '..', 'spec_helper')
require 'yogo/data_app'

# Testing potential endpoints
describe Yogo::DataApp do
  include Rack::Test::Methods

  def app
    setup_rack(Yogo::DataApp)
  end

  before(:all) do
    @cur_schema = Factory.create(:schema)
  end

  after(:all) do
    @cur_schema.destroy
  end

  describe "when retrieving /data/:model_id" do

    it "should return all data" do
      get "/data/#{@cur_schema.name}", :headers => {'accepts' => 'application/json'}

      last_response.should be_ok
      last_response.headers['content-type'].should eql 'application/json'
    end
  end

end