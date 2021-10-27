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

    it 'returns a list of peeps' do
      allow(PG).to receive(:connect).and_return(connection)
      allow(connection).to receive(:exec_params).and_return(result)
      peeps = Peep.all
      expect(peeps[0].content).to eq 'Test Peep 1.'
      expect(peeps[0].time).to eq '00:00'
      expect(peeps[1].id).to eq "2"
      expect(peeps[1].content).to eq 'Test Peep 2.'
      expect(peeps[2].content).to eq 'Test Peep 3.'
      expect(peeps[2].date).to eq '1/1/2022'
    end
  end

  describe '.create' do
    it 'creates a new peep' do
      allow(PG).to receive(:connect).and_return(connection)
      allow(connection).to receive(:exec_params).with("INSERT INTO peeps (content, timestamp) VALUES ('a test', '2022-01-01 00:00:00 +0000') RETURNING id, content, timestamp").and_return('Test pass')
      peep = Peep.create(content: 'a test')
      expect(peep).to eq 'Test pass'
    end
  end
end
