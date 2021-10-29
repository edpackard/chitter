require_relative 'database_connection'
require 'date'

class Peep

  attr_reader :id, :content, :date, :time

  def initialize(id:, content:, timestamp:)
    @id = id
    @content = content
    time = time_conversion(timestamp)
    @date = time.strftime('%-d/%-m/%Y')
    @time = time.strftime('%H:%M')
  end

  def self.all
    result = DatabaseConnection.query('SELECT * FROM peeps')
    peeps = result.map do |peep|
      Peep.new(id: peep['id'], content: peep['content'], timestamp: peep['timestamp'])
    end
    peeps.reverse
  end

  def self.create(content:)
    time = Time.now
    peep = DatabaseConnection.query("INSERT INTO peeps (content, timestamp) VALUES($1, $2) RETURNING id, content, timestamp;", [content, time])
    Peep.new(id: peep[0]['id'], content: peep[0]['content'], timestamp: peep[0]['timestamp'])
  end

  private

  def time_conversion(timestamp)
    ENV['TZ'] = 'GB'
    original_time = DateTime.parse(timestamp)
    p "orig time"
    p original_time
    bst_offset = Time.parse(original_time.new_offset('+01:00').to_s)
    p "bst offset"
    p bst_offset
    offset = bst_offset.dst? ?  "BST" : "UTC"
    p offset
    p "utc time"
    utc_time = original_time.new_offset(0)
    p  utc_time
    utc_time.new_offset(offset) 
  end


end
