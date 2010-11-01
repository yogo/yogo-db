# encoding: utf-8
require File.join(File.dirname(__FILE__), '..', 'spec_helper')
require 'yogo/model/schema'

# Testing the schema model
describe Schema do

  before(:all) do
    @schema = Factory.create(:schema)
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
    # original_model.auto_migrate!

    @schema.operation('add/property', :age, 'Integer')
    @schema.save
    # @schema.data_model.auto_upgrade!
    # @schema.data_model.i.should_not eql original_model
    @schema.data_model.properties.should_not eql original_model.properties
  end

  # it "should update the attributes" do
  #   updated_schema = {:name => @schema.name,
  #     :operations => [['add/property', :id, 'Serial'],['add/property', :description, 'Text'] ]}
  #   @schema.update(updated_schema)
  #   @schema.operation_definitions.should eql updated_schema[:operations]
  # end

  it "should remove the data_model data while being destroyed"

  describe "the generated data model" do

    before(:all) do

      @schema.operation('add/property', :address, 'String', 'label' => 'Address')
      @schema.operation('add/property', :food, 'Boolean', 'label' => 'Likes Food?')
      @schema.save
    end

    it "should have a reference back to the schema object" do
      model = @schema.data_model

      model.schema.should eql @schema
    end

    # Assume that each add/property op is exacitly 1 property at the end
    it "should have the same number of properties as described in the schema" do
      property_operations = @schema.operation_definitions.select{|op| op[0].eql?('add/property')}

      # There are 3 'default' properties added
      @schema.data_model.properties.length.should eql(property_operations.length + 3)
    end

    describe "json" do
      it "should respond to \#to_json" do
        @schema.data_model.create.should respond_to(:to_json)
      end

      it "should should be valid" do
        item = @schema.data_model.create
        lambda {
          JSON.parse(item.to_json)
        }.should_not raise_exception
      end

      it "should should inclue url and :id keys" do
        JSON.parse(@schema.data_model.create.to_json).should include('url', 'data')
      end
    end

    it "should respond to \#to_url}" do
      @schema.data_model.create.should respond_to(:to_url)
    end

    it "should raise an exception when new and to_url is called" do
      lambda {
        @schema.data_model.new.to_url
      }.should raise_exception

    end

    it "should return valid urls" do
      new_item = @schema.data_model.create
      new_item.to_url.should eql("/data/#{@schema.name}/#{new_item.yogo_id}")
    end

    it "should respond to .parse_json" do
      @schema.data_model.should respond_to(:parse_json)
    end

    describe "parse_json" do

      it "should return a hash ready for the model" do
        json = {:data => {'Address' => 'an address', 'Likes Food?' => true}}.to_json
        opts = @schema.data_model.parse_json(json)
        item = @schema.data_model.new(opts)
        item.should be_valid
      end
    end

    it "should respond to attributes_by_label" do
      @schema.data_model.new.should respond_to(:attributes_by_label)
    end

    it "should return labeled attributed" do
      item = @schema.data_model.new
      attributes = item.attributes_by_label
      attributes.should be_a Hash
      attributes.keys.should include('Address', 'Likes Food?')
    end
  end

  describe "file handling" do
    it "should beable to have a file added" do
      @schema.operation('add/file', :my_file, {'label' => "My File"})
      
      @schema.save
      lambda{
        @schema.data_model.first
      }.should_not raise_exception
    end
  end
end