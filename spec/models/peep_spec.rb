require 'peep'

describe Peep do

  describe '.all' do
    it 'returns all peeps' do
      connection = PG.connect(dbname: 'chitter_test')
      connection.exec("INSERT INTO peeps (content) VALUES ('This is a test peep.');")
      connection.exec("INSERT INTO peeps (content) VALUES ('This is another test peep.');")
      connection.exec("INSERT INTO peeps (content) VALUES ('Yet another test peep.');")
      
      peeps = Peep.all
      expect(peeps).to include('This is a test peep.')
      expect(peeps).to include('This is another test peep.')
      expect(peeps).to include('Yet another test peep.')
    end
  end

  describe '.create' do
    it 'creates a new peep' do
      Peep.create(content: 'Testing testing')
      expect(Peep.all).to include('Testing testing')
    end
  end

end