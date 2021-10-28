require_relative 'database_connection'

class Peep

  attr_reader :id, :content, :date, :time

  def initialize(id:, content:, timestamp:)
    @id = id
    @content = content
    @date = Time.parse(timestamp).strftime('%-d/%-m/%Y')
    @time = Time.parse(timestamp).strftime('%H:%M')
  end

  def self.all
    result = DatabaseConnection.query('SELECT * FROM peeps')
    peeps = result.map do |peep|
      Peep.new(id: peep['id'], content: peep['content'], timestamp: peep['timestamp'])
    end
    peeps.reverse
  end

  def self.create(content:)
    peep = DatabaseConnection.query("INSERT INTO peeps (content, timestamp) VALUES($1, $2) RETURNING id, content, timestamp;", [content, Time.now])
    Peep.new(id: peep[0]['id'], content: peep[0]['content'], timestamp: peep[0]['timestamp'])
  end

end
