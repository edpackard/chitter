require 'pg'

def setup_test_database
  p 'Setting up test database...'
  connection = DatabaseConnection.setup({'dbname'=>'chitter_test'})
  connection.exec("TRUNCATE peeps;")
end
