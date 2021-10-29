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
      expect(peeps[2].time).to eq DateTime.parse("2021-01-01 00:00:00+00")
      expect(peeps[1].id).to eq "3"
      expect(peeps[1].content).to eq 'Test Peep - middle.'
      expect(peeps[0].content).to eq 'Test Peep - latest.'
      expect(peeps[0].time).to eq DateTime.parse("2023-01-01 00:00:00+00")
    end

  end

  describe '.create' do
    it 'creates a new peep (converts to UK time - timestamp outside BST)', :no_database_setup do
      allow(DatabaseConnection).to receive(:query).and_return([{ "id" => '1', "content" => 'Test pass', "timestamp" => '2022-01-01 00:00:00 +0000' }])
      peep = Peep.create(content: 'a test')
      expect(peep.content).to eq 'Test pass'
      expect(peep.id).to eq('1')
      expect(peep.time).to eq DateTime.parse('2022-01-01 00:00:00 +0000')
    end

    it 'creates a new peep (converts to UK time - timestamp inside BST)', :no_database_setup do
      allow(DatabaseConnection).to receive(:query).and_return([{ "id" => '1', "content" => 'Test pass', "timestamp" => '2022-06-01 00:00:00 +0000' }])
      peep = Peep.create(content: 'a test')
      expect(peep.content).to eq 'Test pass'
      expect(peep.id).to eq('1')
      expect(peep.time).to eq DateTime.parse('2022-06-01 00:00:00 +0000')
    end

  end
end
