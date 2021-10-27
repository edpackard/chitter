require 'pg'

class Peep

  def self.all

    if ENV['RACK_ENV'] == 'test'
      connection = PG.connect(dbname: 'chitter_test')
    else 
      connection = PG.connect(dbname: 'chitter')
    end
    result = connection.exec('SELECT * FROM peeps')
    result.map { |peep| peep }
  end

  def self.create(content:)
    if ENV['RACK_ENV'] == 'test'
      connection = PG.connect(dbname: 'chitter_test')
    else 
      connection = PG.connect(dbname: 'chitter')
    end
    connection.exec("INSERT INTO peeps (content, timestamp) VALUES ('#{content}', '#{Time.now}') RETURNING content, timestamp")
  end

end
