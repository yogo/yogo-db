require 'dm-types'
require 'yogo/datamapper/model/configuration'
require 'yogo/operations'

class Schema
  include ::DataMapper::Resource
  # include Yogo::DataMapper::Model::Configuration
  include Dataflow
  
  # Common::Properties::UUIDKey[self]
  property :id, ::DataMapper::Property::UUID, {:key => true, :default => lambda{|*args| UUIDTools::UUID.timestamp_create}}

  property :name,                       String,     :required => true, :key => true, :unique => true
  
  property :operation_definitions,      Yaml,       :lazy => false, :default => []
  
  before :save, :reset_data_model
  before :destroy, :destroy_data_model_bucket
  
  # How do we know what variables need to be constantized.
  # Also, we might have more or fewer then 3 parameters in the operation
  # def operation_definitions
  #   @__operation_definitions ||= attribute_get(:op_defs)
  # end
  
  # Set only the operations we want, don't add to them
  def operations=(ops)
    # Clear the current operations
    self.operation_definitions = []
    # Load operations with the set given
    ops.each{|op| operation(*op) }
  end
  
  def operation(op_name, *args)
    op_def = replace_nil_items([op_name.to_s, args].flatten)
    
    unless self.operation_definitions.include?(op_def)
      # We need to dup this else the model doesn't get marked as dirty and won't save.
      self.operation_definitions =  self.operation_definitions.dup << op_def
    end
  end
  
  def data_model
    @data_model ||= by_need { gen_model }
  end
  
  def to_url
    "/schema/#{self.name}"
  end
  
  def to_json(*args)
    options = args.first || {}
    options = options.to_h if options.respond_to?(:to_h)
    
    result = as_json(*args)
    
    if options.fetch(:to_json, true)
      result.to_json
    else
      result
    end
  end
  
  def as_json(*a)
    {
      :guid => self.to_url,
      :name => self.name,
      :operations => self.operation_definitions,
    }
  end
  
  REQUIRED_JSON_KEYS=[:name, :operations]
  
  def self.parse_json(body)
    json = JSON.parse(body)

    ret = { :name => json['name'], :operations => json['operations'] }

    return nil if REQUIRED_JSON_KEYS.any? { |r| ret[r].nil? }
    
    ret
  end
  
  def to_proc
    base_op = Yogo::DataMapper::Model::Operations['add/default_properties']
    # base_op = Yogo::DataMapper::Model::Operations['add/yogo_methods']
    ops = operation_definitions.map{|op_def| Yogo::DataMapper::Model::Operations[op_def.first] }
    partial_ops = []
    ops.each_with_index do |op, i|
      next unless op
      partial_ops[i] = op.partial(X, *operation_definitions[i][1..-1])
    end
    partial_ops << Yogo::DataMapper::Model::Operations['add/yogo_methods']
    partial_ops.compact!
    partial_ops.reduce(base_op){|composed, partial_op| composed * partial_op}

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

    base_model.class_variable_set(:@@schema, self)
    self.to_proc[base_model]
    base_model.auto_upgrade!
    return base_model
  end
  
  def reset_data_model
    @data_model = nil
  end
  
  def destroy_data_model_bucket
    data_model.auto_migrate_down!
  end
  
  def generate_column_uuid
    "col_#{UUIDTools::UUID.timestamp_create.to_s.gsub('-', '_')}"
  end
  
  def replace_nil_items(array)
    array.map{|i| i.nil? ? generate_column_uuid : i }
  end
end # Configuration
