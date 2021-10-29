require 'peep'

describe Peep do

  let(:test_connection) { double(:test_connection) }

  describe '.all' do
    result = [
      { 
        "id" => "1", 
        "content" => "Test Peep - earliest.", 
        "timestamp" => "2021-01-01 00:00:00+00"
      },
      { 
        "id" => "2", 
        "content" => "Test Peep - latest.", 
        "timestamp" => "2023-01-01 00:00:00+00"
      },
      { 
        "id" => "3", 
        "content" => "Test Peep - middle.", 
        "timestamp" => "2022-01-01 00:00:00+00"
      }
    ]

    it 'returns all peeps in reverse chronological order', :no_database_setup do
      allow(DatabaseConnection).to receive(:query).and_return(result)
      peeps = Peep.all
      expect(peeps[2].content).to eq 'Test Peep - earliest.'
      expect(peeps[2].date).to eq ('1/1/2021')
      expect(peeps[1].id).to eq "3"
      expect(peeps[1].content).to eq 'Test Peep - middle.'
      expect(peeps[0].content).to eq 'Test Peep - latest.'
      expect(peeps[0].time).to eq ("00:00")
    end

  end

  describe '.create' do
    it 'creates a new peep', :no_database_setup do
      response = [{ "id" => '1', "content" => 'Test', "timestamp" => '2022-01-01 00:00:00 +0000' }]
      allow(DatabaseConnection).to receive(:query).and_return(response)
      peep = Peep.create(content: 'Test')
      expect(peep.content).to eq 'Test'
      expect(peep.id).to eq('1')
      expect(peep.time).to eq ('00:00')
      expect(peep.date).to eq ('1/1/2022')
    end

    it 'creates new peep (converts non-UTC to UK time (non-DST example))', :no_database_setup do
      response = [{ "id" => '1', "content" => 'Test', "timestamp" => '2022-12-25 06:00:00 +0600' }]
      allow(DatabaseConnection).to receive(:query).and_return(response)
      peep = Peep.create(content: 'Test')
      expect(peep.time).to eq ('00:00')
      expect(peep.date).to eq ('25/12/2022')
    end

    it 'creates new peep (converts UTC time to UK time (DST example))', :no_database_setup do
      response = [{ "id" => '1', "content" => 'Test', "timestamp" => '2022-06-01 23:00:00 +0000' }]
      allow(DatabaseConnection).to receive(:query).and_return(response)
      peep = Peep.create(content: 'Test')
      expect(peep.time).to eq ('00:00')
      expect(peep.date).to eq ('2/6/2022')
    end

    it 'creates new peep (converts non-UTC to UK time (DST example))', :no_database_setup do
      response = [{ "id" => '1', "content" => 'Test', "timestamp" => '1984-06-01 06:00:00 +0600' }]
      allow(DatabaseConnection).to receive(:query).and_return(response)
      peep = Peep.create(content: 'Test')
      expect(peep.time).to eq ('01:00')
      expect(peep.date).to eq ('1/6/1984')
    end

  end
end
