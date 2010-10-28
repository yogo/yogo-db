source :rubygems
gemspec

gem "yogo-datamapper", :git => "git://github.com/yogo/yogo-datamapper.git"
gem "yogo-operation", :git => "git://github.com/yogo/yogo-operation.git"
#gem "yogo-support", :git => "git://github.com/yogo/yogo-support.git"

#
# Development and Test Dependencies
#
group :development, :test do
  platforms(:mri_19) do
    gem "ruby-debug19",       :require => "ruby-debug"
    gem "rack-debug19",       :require => "rack-debug"
  end

  platforms(:ruby_18) do
    gem "ruby-debug"
    gem "rack-debug"
  end
end

group :development, :test do
  gem "racksh"
  gem "sinatra-reloader"
  gem "rake"
  gem "jeweler"
  gem "yard"
  gem "yardstick"
  # Testing gems.
  gem "rspec"
  gem "rack-test"
  gem "cucumber"
  gem "autotest"
  gem 'factory_girl'
end
