require_relative 'database_connection'
require 'date'

class Peep

  attr_reader :id, :content, :date, :time

  def initialize(id:, content:, timestamp:)
    original_timestamp = DateTime.parse(timestamp)
    offset = Time.now.strftime("%:z")
    converted_timestamp = original_timestamp.new_offset(offset)
    @id = id
    @content = content
    @date = converted_timestamp.strftime('%-d/%-m/%Y')
    @time = converted_timestamp.strftime('%H:%M')
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
