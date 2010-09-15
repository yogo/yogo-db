#
# DataMapper Configuration 
#

databases = YAML.load_file(File.join(File.dirname(__FILE__), '..', 'config', 'database.yml'))

DataMapper.setup(:default, databases['development'])
