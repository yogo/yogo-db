# encoding: utf-8
require File.join(File.dirname(__FILE__), '..', 'spec_helper')
require 'yogo/model/schema'

# Testing the data model model
describe 'Data Model' do
  
  before(:all) do
    @schema = Factory.create(:schema)
    @data_model = @schema.data_model
  end

  after(:all) do
    @schema.destroy
  end

  it "should point to the schema it came from" do
    @data_model.schema.should eql @schema
  end

  describe "default properties" do

    it "should have a yogo_id property" do
      @data_model.properties.map(&:name).should include :yogo_id
    end
  
    it "should have a created_at property" do
      @data_model.properties.map(&:name).should include :created_at
    end
  
    it "should have a updated_at property" do
      @data_model.properties.map(&:name).should include :updated_at
    end
  
  end
  
  describe "labeled properties" do
    it "should respond to labeled_properties" do
      @data_model.should respond_to :labeled_properties
    end
    
    it "should be a subset of the properties" do
      subset = (@data_model.properties & @data_model.labeled_properties)
      subset.should eql @data_model.labeled_properties
    end
    
    it "should contain the option 'label'" do
      @data_model.labeled_properties.each{|p| p.options.keys.should include 'label'}
    end
  end
  
end
