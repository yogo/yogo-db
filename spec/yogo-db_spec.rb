require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "YogoDb" do

  def app
    Rack::Builder.new do
      # Place middleware here
      # use Rack::Yogo::Db
      run lambda { |env| [ 200, { 'Content-Type' => 'application/text'}, ["Hello World"]]}
    end
  end
  
  it "should not blow up!" do
    get '/'

    last_response.should be_ok
    last_response.status.should eql 200
    last_response.body.should eql "Hello World"
  end
  
  describe "Retrieving /schema" do
  
    it "should retrive a list of all schemas" do
      get '/schema', :headers => {'accepts' => 'application/json'}
      
      last_response.should be_ok
      last_response.headers['content-type'].should eql 'application/json'
    end
  end
end
