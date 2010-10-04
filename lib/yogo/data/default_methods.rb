module Yogo
  module Data
    module DefaultMethods
      
      def self.included(base)
        base.send(:extend,  ClassMethods)
        base.send(:include, InstanceMethods)
      end
      
      module ClassMethods
        def schema
          @schema
        end

        def schema=(value)
          @schema=value
        end

        def parse_json(body)
          json = JSON.parse(body)
          props = labeled_properties
          ret = {}
          # I don't think we care about other items passed back.
          json['data'].each_pair do |key,value|
            property = props.select{|p| p.options[:label] == key || p.name == key}
            return nil unless property.length == 1
            # raise Exception, "There shouldn't be more the one property with the same label"
            ret[property.first.name] = value
          end
          return ret
        end
        
        def labeled_properties
          properties.select{|p| !p.options[:label].nil? }
        end

        def unlabeled_properties
          properties.select{|p| p.options[:label].nil? }        
        end
      end

      module InstanceMethods
        def to_url
          raise Exception, "Need to save before item has a url" if new?
          "/data/" << self.model.name << "/" << yogo_id.to_s
        end

        def attributes_by_label
          attributes = {}
          properties.each do |property|
            label = property.options[:label]
            next if label.nil?
            name = property.name
            next unless model.public_method_defined?(name)
            attributes[label] = __send__(name)
          end
          return attributes
        end

        def labeled_properties
          self.class.labeled_properties
        end

        def unlabeled_properties
          self.class.unlabeled_properties
        end

        def to_json(*a)
          data = labeled_properties.reduce({}){ |result, property| result.merge(property.name => __send__(property.name)) }
          default_data = unlabeled_properties.reduce({}){ |result, property| result.merge(property.name => __send__(property.name)) }
          default_data.merge({
            :url => self.to_url,
            :data => data
          }).to_json(*a)
        end
      end
      
    end
  end
end