Gem::Specification.new do |gem|
  gem.authors       = [ "Ryan Heimbuch" ]
  gem.email         = [ "yogo@msu.montana.edu" ]
  gem.description   = "Restful interface to yogo data components"
  gem.summary       = "Restful interface to yogo data components"
  gem.homepage      = "http://yogo.msu.montana.edu"
  gem.date          = "2011-12-20"

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {spec}/*`.split("\n")
  gem.extra_rdoc_files = %w[LICENSE README.txt]

  gem.name          = "yogo-db"
  gem.require_paths = [ "lib" ]
  
  gem.version       = "0.5.0"


  gem.add_runtime_dependency("sinatra")
  gem.add_runtime_dependency("rack")
  gem.add_runtime_dependency("activesupport")
  gem.add_runtime_dependency("data_mapper", "~> 1.0.2")
  gem.add_runtime_dependency("dm-sqlite-adapter")
  gem.add_runtime_dependency("dm-postgres-adapter")
  gem.add_runtime_dependency("yogo-operation")
  gem.add_runtime_dependency("yogo-datamapper")
  gem.add_runtime_dependency("json")
  gem.add_runtime_dependency("carrierwave")
end
