require 'peep'

describe Peep do

  let(:connection) { double(:connection) }

  describe '.all' do
    result = [
      { 
        "id"=>"1", 
        "content"=>"Test Peep 1.", 
        "timestamp"=>"2022-01-01 00:00:00+00"
      },
      { 
        "id"=>"2", 
        "content"=>"Test Peep 2.", 
        "timestamp"=>"2022-01-01 00:00:00+00"
      },
      { 
        "id"=>"3", 
        "content"=>"Test Peep 3.", 
        "timestamp"=>"2022-01-01 00:00:00+00"
      }
    ]

    it 'returns all peeps in reverse chronological order' do
      allow(PG).to receive(:connect).and_return(connection)
      allow(connection).to receive(:exec).and_return(result)
      peeps = Peep.all
      expect(peeps[2].content).to eq 'Test Peep 1.'
      expect(peeps[2].time).to eq '00:00'
      expect(peeps[1].id).to eq "2"
      expect(peeps[1].content).to eq 'Test Peep 2.'
      expect(peeps[0].content).to eq 'Test Peep 3.'
      expect(peeps[0].date).to eq '1/1/2022'
    end
  end

  describe '.create' do
    it 'creates a new peep' do
      allow(PG).to receive(:connect).and_return(connection)
      allow(connection).to receive(:exec_params).with("INSERT INTO peeps (content, timestamp) VALUES($1, $2) RETURNING id, content, timestamp;", ["a test", Time.now]).and_return([{"id"=>'1', "content"=>'Test pass', "timestamp"=>'2022-01-01 00:00:00 +0000'}])
      peep = Peep.create(content: 'a test')
      expect(peep.content).to eq 'Test pass'
      expect(peep.id).to eq('1')
      expect(peep.time).to eq('00:00')
      expect(peep.date).to eq('1/1/2022')
    end
  end
end
