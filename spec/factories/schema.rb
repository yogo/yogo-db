# Defining a schema factory

Factory.define(:schema) do |u|
  u.sequence(:name) {|n| "yogo_#{n}"}
  u.operation_definitions [['add/property', :id, 'Serial']]

end