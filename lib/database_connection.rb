require 'pg'

class DatabaseConnection

  def self.setup(connection)
    @connection = PG.connect(connection)
  end

  def self.query(sql, params = [])
    @connection.exec_params(sql, params)
  end

end
