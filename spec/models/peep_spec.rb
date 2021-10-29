require 'peep'
require 'timecop'

describe Peep do

  describe '.all' do
    it 'returns all peeps in reverse chronological order' do
      time = Time.utc(2022, 1, 1, 0, 0, 0)
      Timecop.freeze(time)
      peep = Peep.create(content: 'This is a test peep.')
      time = Time.utc(2023, 1, 1, 0, 0, 0)
      Timecop.freeze(time)
      Peep.create(content: 'This is another test peep.')
      time = Time.utc(2024, 1, 1, 0, 0, 0)
      Timecop.freeze(time)  
      Peep.create(content: 'Yet another test peep.')
      
      peeps = Peep.all
      expect(peeps.length).to eq 3
      expect(peeps.first).to be_a Peep
      expect(peeps.last.id).to eq(peep.id)
      expect(peeps.last.content).to eq('This is a test peep.')
    end

  end

  describe '.create' do
    it 'creates a new peep' do
      time = Time.utc(2022, 1, 1, 0, 0, 0)
      Timecop.freeze(time)
      datetime = DateTime.parse(time.to_s)
      peep = Peep.create(content: 'Testing testing')
      persisted_data = DatabaseConnection.setup(dbname: 'chitter_test').query("SELECT * FROM peeps WHERE id = #{peep.id};")
      
      expect(peep).to be_a Peep
      expect(peep.id).to eq(persisted_data.first['id'])
      expect(peep.content).to eq('Testing testing')
      expect(peep.time).to eq datetime
    end

    it 'converts times to UK time including BST' do
      time = Time.utc(2022, 6, 1, 0, 0, 0)
      Timecop.freeze(time)
      datetime = DateTime.parse(time.to_s)
      peep = Peep.create(content: 'Testing testing')
      expect(peep.time).to eq datetime
    end
  end

end
