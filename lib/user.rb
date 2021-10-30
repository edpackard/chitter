require_relative 'database_connection'

class User

  attr_reader :id, :name, :password, :email

  def initialize(id:, email:, name:, password:)
    @id = id
    @email = email
    @password = password
    @name = name
  end

  def self.create(name:, email:, password:)
    result = DatabaseConnection.query(
      "INSERT INTO users (name, email, password) VALUES($1, $2, $3) RETURNING id, name, password, email;",
      [name, email, password]
    )
    User.new(
      id: result[0]['id'], name: result[0]['name'], 
      email: result[0]['email'], password: result[0]['password']
    )
  end

  def self.find(id)
    return nil unless id
    result = DatabaseConnection.query(
        "SELECT * FROM users WHERE id = $1",
      [id]
    )
    User.new(
      id: result[0]['id'], name: result[0]['name'], 
      email: result[0]['email'], password: result[0]['password']
    )
  end

end
