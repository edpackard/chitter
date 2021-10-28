require './lib/database_connection'

if ENV['RACK_ENV'] == 'test'
  DatabaseConnection.setup(dbname: 'chitter_test')
elsif ENV['RACK_ENV'] == 'production'
  DatabaseConnection.setup(ENV['DATABASE_URL'])
else
  DatabaseConnection.setup(dbname: 'chitter')
end