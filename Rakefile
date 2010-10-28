begin
  require 'bundler'
  Bundler.setup
  Bundler::GemHelper.install_tasks
rescue LoadError
  puts "Bundler is not intalled. Install with: gem install bundler"
end

begin
  require 'rack-debug/tasks'
rescue LoadError

end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "yogo-db"
    gem.summary = "Yogo DB Rest components"
    gem.description = "Restful interface to yogo data components"
    gem.email = "rheimbuch@gmail.com"
    gem.homepage = "http://github.com/yogo/yogo-db"
    gem.authors = ["Ryan Heimbuch"]
    gem.add_bundler_dependencies
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

desc 'Run all examples using rcov'
RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.rcov = true
  spec.rcov_opts =  %[-Ilib -Ispec --exclude "mocks,expectations,gems/*,spec/resources,spec/lib,spec/spec_helper.rb,db/*,/Library/Ruby/*,config/*"]
  spec.rcov_opts << %[--no-html --aggregate coverage.data]
end

# task :spec => :check_dependencies

begin
  require 'cucumber/rake/task'
  Cucumber::Rake::Task.new(:features)

  task :features => :check_dependencies
rescue LoadError
  task :features do
    abort "Cucumber is not available. In order to run features, you must: sudo gem install cucumber"
  end
end

task :default => :spec

begin
  require 'yard'
  YARD::Rake::YardocTask.new
rescue LoadError
  task :yardoc do
    abort "YARD is not available. In order to run yardoc, you must: sudo gem install yard"
  end
end
