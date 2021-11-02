require_relative 'database_connection'
require 'date'

class Peep

  def self.all(connection = DatabaseConnection)
    result = connection.query('SELECT * FROM peeps;')
    peeps = result.map do |peep|
      Peep.new(
        id: peep['id'], content: peep['content'], timestamp: peep['timestamp'], 
        user_id: peep['user_id'], connection: connection
      )
    end
    peeps.sort_by { |peep| peep.timestamp }.reverse
  end

  def self.create(content:, user_id:, connection: DatabaseConnection)
    return false if content.length.zero? || content.length > 140
    sql = "INSERT INTO peeps (content, timestamp, user_id)"\
    "VALUES($1, $2, $3) RETURNING id, content, timestamp, user_id;"
    peep = connection.query(sql, [content, Time.now, user_id])
    Peep.new(
      id: peep[0]['id'], content: peep[0]['content'], timestamp: peep[0]['timestamp'], 
      user_id: user_id, connection: connection
    )
  end

  attr_reader(
    :content,  
    :id, 
    :name,
    :timestamp
  )

  def initialize(id:, content:, timestamp:, user_id:, connection:)
    @id = id
    @content = content
    @timestamp = timezone_convert(timestamp)
    @name = find_name(user_id, connection)
  end

  def time
    @timestamp.strftime('%H:%M')
  end

  def date
    @timestamp.strftime('%-d/%-m/%Y')
  end

  private

  def timezone_convert(timestamp)
    ENV['TZ'] = 'GB'
    original_time = DateTime.parse(timestamp)
    dst_offset = Time.parse(original_time.new_offset('+01:00').to_s)
    offset = dst_offset.dst? ? "BST" : "UTC"
    original_time.new_offset(offset)
  end

  def find_name(user_id, connection)
    return 'Unknown' unless user_id
    name = connection.query("SELECT name FROM users WHERE id=#{user_id}")
    name[0]['name']
  end

end
