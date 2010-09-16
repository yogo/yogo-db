require 'dm-types'
require 'yogo/datamapper/model/configuration'

class Schema
  include ::DataMapper::Resource
  include Yogo::DataMapper::Model::Configuration
  
  # Common::Properties::UUIDKey[self]
  property :id, ::DataMapper::Property::UUID, {:key => true, :default => lambda{|*args| UUIDTools::UUID.timestamp_create}}

  property :name,                       String,     :required => true, :key => true, :unique => true
  
  property :op_defs,                    Yaml,       :lazy => false, :default => []
  
  before :save, :stringify_objects
  
  # How do we know what variables need to be constantized.
  # Also, we might have more or fewer then 3 parameters in the operation
  def operation_definitions
    @__operation_definitions ||= attribute_get(:op_defs)
  end
  
  def generate_model
    base_model = ::DataMapper::Model.new do
      def self.default_storage_name
        config.id
      end
    
      def name
        model_name
      end
    end
    
    return self.to_proc[base_model]
  end
  
  private
  
  def stringify_objects
    attribute_set(:op_defs, @__operation_definitions)
  end
end # Configuration
