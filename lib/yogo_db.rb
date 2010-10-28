%w[
    activesupport
    dm-core
    dm-migrations
    dm-validations
    dm-sqlite-adapter
    dm-postgres-adapter
    yogo-operation
    yogo-datamapper
    json
  ].each do |lib|
    require lib
  end
