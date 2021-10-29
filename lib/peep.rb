require_relative 'database_connection'
require 'date'

class Peep

  attr_reader :id, :content, :timestamp, :time, :date

  def initialize(id:, content:, timestamp:)
    @id = id
    @content = content
    @timestamp = timezone_convert(timestamp)
    @time =  @timestamp.strftime('%H:%M')
    @date =  @timestamp.strftime('%-d/%-m/%Y')
  end

  def self.all
    result = DatabaseConnection.query('SELECT * FROM peeps;')
    peeps = result.map do |peep|
      Peep.new(id: peep['id'], content: peep['content'], timestamp: peep['timestamp'])
    end
    peeps.sort_by { |peep| peep.timestamp }.reverse
  end

  def self.create(content:)
    sql = "INSERT INTO peeps (content, timestamp) VALUES($1, $2) RETURNING id, content, timestamp;" 
    time = Time.now
    peep = DatabaseConnection.query(sql, [content, time])
    Peep.new(id: peep[0]['id'], content: peep[0]['content'], timestamp: peep[0]['timestamp'])
  end

  private

  def timezone_convert(timestamp)
    ENV['TZ'] = 'GB'
    original_time = DateTime.parse(timestamp)
    dst_offset = Time.parse(original_time.new_offset('+01:00').to_s)
    offset = dst_offset.dst? ? "BST" : "UTC"
    original_time.new_offset(offset)
  end

end
