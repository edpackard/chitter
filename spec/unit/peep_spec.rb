require 'peep'

describe Peep do

  let(:connection) { double(:connection) }

  describe '.all' do
    result = [
      { 'content' => 'Test Peep 1' }, 
      { 'content' => 'Test Peep 2' }, 
      { 'content' => 'Test Peep 3' }
    ]

    it 'returns a list of peeps' do
      allow(PG).to receive(:connect).and_return(connection)
      allow(connection).to receive(:exec).and_return(result)
      peeps = Peep.all
      expect(peeps[0]['content']).to include 'Test Peep 1'
      expect(peeps[1]['content']).to include 'Test Peep 2'
      expect(peeps[2]['content']).to include 'Test Peep 3'
    end
  end

  describe '.create' do
    it 'creates a new peep' do
      allow(PG).to receive(:connect).and_return(connection)
      allow(connection).to receive(:exec).with("INSERT INTO peeps (content, timestamp) VALUES ('a test', '2022-01-01 00:00:00 +0000') RETURNING content, timestamp").and_return('Test pass')
      peep = Peep.create(content: 'a test')
      expect(peep).to eq 'Test pass'
    end
  end
end
