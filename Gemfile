source :rubygems

gemspec

gem 'yogo-operation',         :git => 'git://github.com/yogo/yogo-operation.git',
                              :require => nil
gem 'yogo-datamapper',        :git => 'git://github.com/yogo/yogo-datamapper.git',
                              :require => nil

group :development, :test do
  platforms(:ruby_19) do
    gem 'ruby-debug19',       :require => 'ruby-debug'
    gem 'rack-debug19',       :require => 'rack-debug'
  end

  platforms(:ruby_18) do
    gem "ruby-debug"
    gem "rack-debug"
  end
end

RSPEC_VERSION = '~> 2.0.0.beta.22'

group :test do
  gem "rspec",                RSPEC_VERSION
  gem "autotest"
  gem "rack-test"
  gem "cucumber"
  gem 'factory_girl'
end