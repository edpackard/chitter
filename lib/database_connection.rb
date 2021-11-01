require 'pg'

class DatabaseConnection

  def self.setup(connection, client = PG)
    @connection = client.connect(connection)
  end

  def self.query(sql, params = [])
    @connection.exec_params(sql, params)
  end

end
