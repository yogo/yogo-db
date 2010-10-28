# Defining a schema factory
Factory.define(:schema) do |u|
  u.sequence(:name) { |n| "yogo_#{n}" }
  u.operations [['add/property', :name, 'String']]
end