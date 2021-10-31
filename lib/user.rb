require_relative 'database_connection'

require 'bcrypt'

class User

  attr_reader :id, :name, :email

  def initialize(id:, email:, name:)
    @id = id
    @email = email
    @name = name
  end

  def self.create(name:, email:, password:)
    return false if invalid_params?(name, email, password)
    result = DatabaseConnection.query(
      "INSERT INTO users (name, email, password) VALUES($1, $2, $3) RETURNING id, name, email;",
      [name, email, encrypted_password(password)]
    )
    User.new(
      id: result[0]['id'], name: result[0]['name'], email: result[0]['email']
    )
  end

  def self.find(id)
    return nil unless id
    result = DatabaseConnection.query(
        "SELECT * FROM users WHERE id = $1",
      [id]
    )
    User.new(
      id: result[0]['id'], name: result[0]['name'], email: result[0]['email']
    )
  end

  private
  
  def self.encrypted_password(password)
    BCrypt::Password.create(password)
  end

  def self.invalid_params?(name, email, password)
    name.length.zero? || name.length > 15 || 
    email.length.zero? || email.length > 60 || 
    password.length.zero? || password.length > 140
  end


end
