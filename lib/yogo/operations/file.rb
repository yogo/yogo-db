# Operation to add a file type here

Yogo::DataMapper::Model::Operations['add/file'] = Yogo::Op.on(::DataMapper::Model) do |model, name, options|

  asset_root = options.delete('asset_root') || ASSET_PATH

  uploader = Class.new(CarrierWave::Uploader::Base)
  uploader.storage(:file)
  uploader.class_eval %{
    def store_dir
      File.join('#{asset_root}', '#{model.schema.id}', '#{name}')
    end
    
    def filename
      # Digest::MD5.hexdigest(self.read)
      UUIDTools::UUID.timestamp_create
    end
  }, __FILE__, __LINE__

  # asset_name = "#{name}_asset_file"

  # model.define some properties
  model.class_eval do
    without_auto_validations do
      # property :content_type,       String
      # property :description,        String
      property name.to_sym,         String, options
      property "#{name}_original_filename".to_sym,  String
    end
    
    mount_uploader name.to_sym, uploader, :mount_on => name.to_sym
    after "#{name}=".to_sym, "write_#{name}_identifier".to_sym
    after "#{name}=".to_sym, "set_#{name}_original_filename".to_sym
  end

  model.class_eval %{
    private 
  
    def set_#{name}_original_filename
      original_filename = #{name}.send(:original_filename)
      attribute_set(:#{name}_original_filename, original_filename)
    end
  }, __FILE__, __LINE__+1


  model

end