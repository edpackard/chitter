require 'pg'

def persisted_data(id:, table:)
  connection = PG.connect(dbname: 'chitter_test')
  result = connection.query("SELECT * FROM #{table} WHERE id = #{id};")
  result.first
end

def insert_user_into_db(name:, email:, password:)
  connection = PG.connect(dbname: 'chitter_test')
  connection.exec_params(
    "INSERT INTO users (name, email, password) VALUES($1, $2, $3);",[name, email, password]
  )
end

def get_user_id(name:)
  connection = PG.connect(dbname: 'chitter_test')
  user = connection.query("SELECT * FROM users WHERE name='#{name}';")
  user.first['id']
end
