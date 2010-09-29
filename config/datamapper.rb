#
# DataMapper Configuration 
#

databases = YAML.load_file(File.join(File.dirname(__FILE__), '..', 'config', 'database.yml'))

DataMapper::Model.raise_on_save_failure = true
DataMapper::Logger.new('log/datamapper.log', :debug)
DataMapper.setup(:default, databases[ENV['RACK_ENV'] || 'development'])
