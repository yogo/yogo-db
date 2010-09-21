require 'dm-types'
require 'yogo/datamapper/model/configuration'

class Schema
  include ::DataMapper::Resource
  include Yogo::DataMapper::Model::Configuration
  include Dataflow
  
  # Common::Properties::UUIDKey[self]
  property :id, ::DataMapper::Property::UUID, {:key => true, :default => lambda{|*args| UUIDTools::UUID.timestamp_create}}

  property :name,                       String,     :required => true, :key => true, :unique => true
  
  property :op_defs,                    Yaml,       :lazy => true, :default => []
  
  before :save, :set_op_defs
  before :destroy, :destroy_data_model_bucket
  
  # How do we know what variables need to be constantized.
  # Also, we might have more or fewer then 3 parameters in the operation
  def operation_definitions
    @__operation_definitions ||= attribute_get(:op_defs)
  end
  
  def data_model
    @data_model ||= by_need { gen_model }
     # by_need { gen_model }
    # @data_model ||= gen_model
  end
  
  def to_url
    "/schema/#{self.name}"
  end
  
  def to_json(*a)
    {
      :guid => self.to_url,
      :name => self.name,
      :op_defs => self.op_defs,
      
    }.to_json(*a)
  end
  
  REQUIRED_JSON_KEYS=[:name, :op_defs]
  
  def self.parse_json(body)
    json = JSON.parse(body)

    ret = { :name => json['name'], :op_defs => json['op_defs'] }

    return nil if REQUIRED_JSON_KEYS.any? { |r| ret[r].nil? }
    
    ret
  end
  
  private
  
  def gen_model
    id = attribute_get(:id)
    model_name = attribute_get(:name)
    base_model = ::DataMapper::Model.new do
      class_eval <<-RUBY, __FILE__, __LINE__ + 1
        def self.default_storage_name
          "#{id}"
        end
          
        def self.name
          "#{model_name}"
        end
      RUBY
    end
    
    return self.to_proc[base_model]
  end
  
  def set_op_defs
    attribute_set(:op_defs, @__operation_definitions)
    @data_model = nil
  end
  
  def destroy_data_model_bucket
    data_model.auto_migrate_down!
  end
end # Configuration
