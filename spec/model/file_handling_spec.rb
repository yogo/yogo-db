# encoding: utf-8
require File.join(File.dirname(__FILE__), '..', 'spec_helper')
require 'yogo/model/schema'

# Testing the data model model
describe 'Data Model' do
  
  before(:all) do
    @schema = Factory.create(:schema, :operations => [['add/file', 'a_file', {'label' => 'A File'}]] )
    @data_model = @schema.data_model
    @file = File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')
  end

  after(:all) do
    @schema.destroy
  end
  

  it "should accept a file" do
    item = @data_model.new
    item.a_file = File.open(@file)
    item.save
    @data_model.get(item.yogo_id).a_file.file.should be_kind_of CarrierWave::SanitizedFile
  end
  
  it "should have an original filename property" do
    @data_model.properties.map(&:name).should include(:a_file_original_filename)
  end
  
  it "should take a asset_root option" do
    asset_root = File.join(File.dirname(__FILE__), 'assets_testing')
    schema = Factory.create(:schema, :operations => [['add/file', 'a_file', {'label' => 'A File', 'asset_root' => asset_root}]] )
    item = schema.data_model.new
    item.a_file = File.open(@file)
    item.save
    item.a_file.path.should include(asset_root)
  end
  
  # it "should save a file to the file property" do
  #   
  # end
end