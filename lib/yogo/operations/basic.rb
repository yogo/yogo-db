require 'yogo/operation'
require 'yogo/data/default_methods'

# Move into DataMapper::Property extension file
unless ::DataMapper::Property.accepted_options.include?('label')
  ::DataMapper::Property.accept_options('label')
end

module Operations
  Yogo::DataMapper::Model::Operations['add/yogo_methods'] = Yogo::Op.on(::DataMapper::Model) do |model|

    # model.define some properties

    model.send(:include, Yogo::Data::DefaultMethods)

    model

  end

  Yogo::DataMapper::Model::Operations['add/yogo_id_property'] =
          Yogo::DataMapper::Model::Operations['add/property'].partial(X, :yogo_id, 'Serial', {})
  Yogo::DataMapper::Model::Operations['add/created_at_property'] =
          Yogo::DataMapper::Model::Operations['add/property'].partial(X, :created_at, 'DateTime', {})
  Yogo::DataMapper::Model::Operations['add/updated_at_property'] =
          Yogo::DataMapper::Model::Operations['add/property'].partial(X, :updated_at, 'DateTime', {})

  Yogo::DataMapper::Model::Operations['add/default_properties'] =
    Yogo::DataMapper::Model::Operations['add/yogo_id_property'] *
    Yogo::DataMapper::Model::Operations['add/created_at_property'] *
    Yogo::DataMapper::Model::Operations['add/updated_at_property']
end