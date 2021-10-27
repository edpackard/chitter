require 'pg'

class Peep

  attr_reader :id, :content, :date, :time

  def initialize(id:, content:, timestamp:)
    @id = id
    @content = content
    @date = Time.parse(timestamp).strftime('%-d/%-m/%Y')
    @time = Time.parse(timestamp).strftime('%H:%M')
  end

  def self.all

    if ENV['RACK_ENV'] == 'test'
      connection = PG.connect(dbname: 'chitter_test')
    elsif ENV['RACK_ENV'] == 'production'
      connection = PG.connect(ENV['DATABASE_URL'])
    else
      connection = PG.connect(dbname: 'chitter')
    end
    result = connection.exec_params('SELECT * FROM peeps')
    peeps = result.map do |peep|
      Peep.new(id: peep['id'], content: peep['content'], timestamp: peep['timestamp'])
    end
    peeps.reverse
  end

  def self.create(content:)
    if ENV['RACK_ENV'] == 'test'
      connection = PG.connect(dbname: 'chitter_test')
    elsif ENV['RACK_ENV'] == 'production'
      connection = PG.connect(ENV['DATABASE_URL'])
    else 
      connection = PG.connect(dbname: 'chitter')
    end
    peep = connection.exec_params("INSERT INTO peeps (content, timestamp) VALUES ('#{content}', '#{Time.now}') RETURNING id, content, timestamp")
    Peep.new(id: peep[0]['id'], content: peep[0]['content'], timestamp: peep[0]['timestamp'])
  end

end
