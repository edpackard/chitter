require_relative 'database_connection'
require 'date'

class Peep

  attr_reader :id, :content, :date, :time

  def initialize(id:, content:, timestamp:)
    @id = id
    @content = content
    @time = timezone_convert(timestamp)
  end

  def self.all
    result = DatabaseConnection.query('SELECT * FROM peeps;')
    peeps = result.map do |peep|
      Peep.new(id: peep['id'], content: peep['content'], timestamp: peep['timestamp'])
    end
    peeps.sort_by { |peep| peep.time }.reverse
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
