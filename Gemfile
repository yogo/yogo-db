source :rubygems

RSPEC_VERSION = '2.0.0.beta.22'

gem 'rack'

gem 'yogo-datamapper',        :git => 'git://github.com/yogo/yogo-datamapper.git'


group :development do
  gem "rake"
  gem "jeweler"
  gem "rspec",                RSPEC_VERSION
  gem "autotest"
  gem "rack-test"
  gem "cucumber"
  gem "yard"
  
  platforms(:mri_19) do
    gem 'ruby-debug19',       :require => 'ruby-debug'
    gem 'rack-debug19',       :require => 'rack-debug'
  end
  
  platforms(:mri_18) do
    gem "ruby-debug"
    gem "rack-debug"
  end
  
end