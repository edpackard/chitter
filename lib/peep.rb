require_relative 'database_connection'
require 'date'

class Peep

  attr_reader :id, :content, :timestamp, :time, :date, :name

  def initialize(id:, content:, timestamp:, user_id:)
    @id = id
    @content = content
    @timestamp = timezone_convert(timestamp)
    @time = @timestamp.strftime('%H:%M')
    @date = @timestamp.strftime('%-d/%-m/%Y')
    @name = find_name(user_id)
  end

  def self.all
    result = DatabaseConnection.query('SELECT * FROM peeps;')
    peeps = result.map do |peep|
      Peep.new(id: peep['id'], content: peep['content'], timestamp: peep['timestamp'], user_id: peep['user_id'])
    end
    peeps.sort_by { |peep| peep.timestamp }.reverse
  end

  def self.create(content:, user_id:)
    return if content == ""
    sql = "INSERT INTO peeps (content, timestamp, user_id) VALUES($1, $2, $3) RETURNING id, content, timestamp, user_id;" 
    time = Time.now
    peep = DatabaseConnection.query(sql, [content, time, user_id])
    Peep.new(id: peep[0]['id'], content: peep[0]['content'], timestamp: peep[0]['timestamp'], user_id: user_id)
  end

  private

  def timezone_convert(timestamp)
    ENV['TZ'] = 'GB'
    original_time = DateTime.parse(timestamp)
    dst_offset = Time.parse(original_time.new_offset('+01:00').to_s)
    offset = dst_offset.dst? ? "BST" : "UTC"
    original_time.new_offset(offset)
  end

  def find_name(user_id)
    return 'Unknown' unless user_id
    name = DatabaseConnection.query("SELECT name FROM users WHERE id=#{user_id}")
    name[0]['name']
  end

end
