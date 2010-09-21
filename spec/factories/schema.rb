# Defining a schema factory

Factory.define(:schema) do |u|
  u.sequence(:name) {|n| "yogo_#{n}"}
  u.op_defs [['add/property', :id, 'Serial']]

end