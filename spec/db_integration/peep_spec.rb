require 'database_helpers'
require 'peep'
require 'timecop'

describe Peep do

  describe '.all' do
    it 'retrieves peeps from database and displays them in reverse chronological order' do
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
    it 'creates a new peep in the database' do
      time = Time.utc(2022, 1, 1, 0, 10, 0)
      Timecop.freeze(time)
      peep = Peep.create(content: 'Testing testing')
      persisted_data = persisted_data(id: peep.id, table: :peeps)
      expect(peep).to be_a Peep
      expect(peep.id).to eq(persisted_data['id'])
      expect(peep.content).to eq('Testing testing')
      expect(peep.time).to eq('00:10')
      expect(peep.date).to eq('1/1/2022')
    end

  end

end
