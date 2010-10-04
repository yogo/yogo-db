source :rubygems

RSPEC_VERSION = '~> 2.0.0.beta.22'

gem 'sinatra'
gem 'rack'

gem 'activesupport' # For Datamapper

gem 'dm-core'
gem 'dm-migrations'
# gem 'dm-serializer'
gem 'dm-validations'

gem 'dm-sqlite-adapter', :require => nil
gem 'dm-postgres-adapter',    :require => nil

gem 'yogo-operation',         :git => 'git://github.com/yogo/yogo-operation.git',
                              :require => nil
gem 'yogo-datamapper',        :git => 'git://github.com/yogo/yogo-datamapper.git', 
                              :require => nil


gem 'json'

group :development, :test do
  gem "rake"
  gem "jeweler"

  gem "yard"
  
  gem 'sinatra-reloader', :require => 'sinatra/reloader'
  
  platforms(:mri_19) do
    gem 'ruby-debug19',       :require => 'ruby-debug'
    gem 'rack-debug19',       :require => 'rack-debug'
  end
  
  platforms(:mri_18) do
    gem "ruby-debug"
    gem "rack-debug"
  end
end

group :test do
  gem "rspec",                RSPEC_VERSION
  gem "autotest"
  gem "rack-test"
  gem "cucumber"
  gem 'factory_girl'
end