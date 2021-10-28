require_relative 'database_connection'
require 'date'

class Peep

  attr_reader :id, :content, :date, :time

  def initialize(id:, content:, timestamp:)
    @id = id
    @content = content
    dt = DateTime.parse(timestamp)
    dt = dt.new_offset(DateTime.now.offset)
    @date = dt.strftime('%-d/%-m/%Y')
    @time = dt.strftime('%H:%M')
  end

  def self.all
    result = DatabaseConnection.query('SELECT * FROM peeps')
    peeps = result.map do |peep|
      Peep.new(id: peep['id'], content: peep['content'], timestamp: peep['timestamp'])
    end
    peeps.reverse
  end

  def self.create(content:)
    time = DateTime.now
    peep = DatabaseConnection.query("INSERT INTO peeps (content, timestamp) VALUES($1, $2) RETURNING id, content, timestamp;", [content, time])
    Peep.new(id: peep[0]['id'], content: peep[0]['content'], timestamp: peep[0]['timestamp'])
  end

end
