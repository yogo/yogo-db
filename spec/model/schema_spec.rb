# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/..' + '/spec_helper')

# Testing the middleware and how it modifies the environment
describe Schema do
  
  before(:all) do
    @schema = Schema.new(:name => 'sample_id')
    @schema.operation('add/property', :id, 'Serial')
    @schema.operation('add/property', :name, 'String')
    @schema.save
  end
  
  after(:all) do
    @schema.destroy
  end
  
  it "should generate a proc" do
    Schema.first.to_proc.should be_kind_of Proc
  end
  
  it "should store and generate a model" do
    Schema.first.data_model.should be_a(DataMapper::Model)
  end
  
  it "should update the data_model after being updated" do
    original_model = @schema.data_model
    original_model.auto_migrate!
    @schema.operation('add/property', :age, 'Integer')
    @schema.save
    @schema.data_model.auto_upgrade!
    # @schema.data_model.i.should_not eql original_model
    @schema.data_model.properties.should_not eql original_model.properties
  end
  
  it "should remove the data_model data while being destroyed"
  
end