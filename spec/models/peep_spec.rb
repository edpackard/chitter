require 'peep'
require 'timecop'

describe Peep do

  describe '.all' do
    it 'returns all peeps' do
      connection = PG.connect(dbname: 'chitter_test')
      connection.exec("INSERT INTO peeps (content) VALUES ('This is a test peep.');")
      connection.exec("INSERT INTO peeps (content) VALUES ('This is another test peep.');")
      connection.exec("INSERT INTO peeps (content) VALUES ('Yet another test peep.');")
      
      peeps = Peep.all
      expect(peeps[0]['content']).to include('This is a test peep.')
      expect(peeps[1]['content']).to include('This is another test peep.')
      expect(peeps[2]['content']).to include('Yet another test peep.')
    end
  end

  describe '.create' do
    it 'creates a new peep' do
      time = Time.local(2022, 1, 1)
      Timecop.freeze(time)
      peep = Peep.create(content: 'Testing testing').first
      expect(peep['content']).to eq('Testing testing')
      expect(peep['timestamp']).to eq('2022-01-01 00:00:00+00')
    end
  end

end
