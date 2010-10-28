# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{yogo-db}
  s.version = "0.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ryan Heimbuch"]
  s.date = %q{2010-10-06}
  s.description = %q{Restful interface to yogo data components}
  s.email = %q{rheimbuch@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    ".gitignore",
    ".rspec",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "config.ru",
    "config/database.yml",
    "config/datamapper.rb",
    "features/step_definitions/yogo-db_steps.rb",
    "features/support/env.rb",
    "features/yogo-db.feature",
    "lib/yogo/custom_ops.rb",
    "lib/yogo/data/default_methods.rb",
    "lib/yogo/data_app.rb",
    "lib/yogo/db/.gitdir",
    "lib/yogo/model/schema.rb",
    "lib/yogo/rack/model_lookup.rb",
    "lib/yogo/schema_app.rb",
    "spec/factories/schema.rb",
    "spec/helpers/request_helper.rb",
    "spec/model/schema_spec.rb",
    "spec/spec_helper.rb",
    "spec/yogo/data_app_spec.rb",
    "spec/yogo/model_lookup_spec.rb",
    "spec/yogo/schema_app_spec.rb",
    "yogo-db.gemspec"
  ]
  s.homepage = %q{http://github.com/yogo/yogo-db}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Yogo DB Rest components}
  s.test_files = [
    "spec/factories/schema.rb",
    "spec/helpers/request_helper.rb",
    "spec/model/schema_spec.rb",
    "spec/spec_helper.rb",
    "spec/yogo/data_app_spec.rb",
    "spec/yogo/model_lookup_spec.rb",
    "spec/yogo/schema_app_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<sinatra>, [">= 0"])
      s.add_runtime_dependency(%q<rack>, [">= 0"])
      s.add_runtime_dependency(%q<activesupport>, [">= 0"])
      s.add_runtime_dependency(%q<dm-core>, [">= 0"])
      s.add_runtime_dependency(%q<dm-migrations>, [">= 0"])
      s.add_runtime_dependency(%q<dm-validations>, [">= 0"])
      s.add_runtime_dependency(%q<dm-sqlite-adapter>, [">= 0"])
      s.add_runtime_dependency(%q<dm-postgres-adapter>, [">= 0"])
      s.add_runtime_dependency(%q<json>, [">= 0"])
    else
      s.add_dependency(%q<sinatra>, [">= 0"])
      s.add_dependency(%q<rack>, [">= 0"])
      s.add_dependency(%q<activesupport>, [">= 0"])
      s.add_dependency(%q<dm-core>, [">= 0"])
      s.add_dependency(%q<dm-migrations>, [">= 0"])
      s.add_dependency(%q<dm-validations>, [">= 0"])
      s.add_dependency(%q<dm-sqlite-adapter>, [">= 0"])
      s.add_dependency(%q<dm-postgres-adapter>, [">= 0"])
      s.add_dependency(%q<json>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
      s.add_dependency(%q<yard>, [">= 0"])
      s.add_dependency(%q<sinatra-reloader>, [">= 0"])
    end
  else
    s.add_dependency(%q<sinatra>, [">= 0"])
    s.add_dependency(%q<rack>, [">= 0"])
    s.add_dependency(%q<activesupport>, [">= 0"])
    s.add_dependency(%q<dm-core>, [">= 0"])
    s.add_dependency(%q<dm-migrations>, [">= 0"])
    s.add_dependency(%q<dm-validations>, [">= 0"])
    s.add_dependency(%q<dm-sqlite-adapter>, [">= 0"])
    s.add_dependency(%q<dm-postgres-adapter>, [">= 0"])
    s.add_dependency(%q<json>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
    s.add_dependency(%q<yard>, [">= 0"])
    s.add_dependency(%q<sinatra-reloader>, [">= 0"])
  end
end

