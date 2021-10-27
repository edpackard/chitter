require 'peep'
require 'timecop'

describe Peep do

  describe '.all' do
    it 'returns all peeps in reverse chronological order' do
      time = Time.local(2022, 1, 1)
      Timecop.freeze(time)
      peep = Peep.create(content: 'This is a test peep.')
      Peep.create(content: 'This is another test peep.')
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
      time = Time.local(2022, 1, 1)
      Timecop.freeze(time)
      peep = Peep.create(content: 'Testing testing')
      persisted_data = PG.connect(dbname: 'chitter_test').query("SELECT * FROM peeps WHERE id = #{peep.id};")

      expect(peep).to be_a Peep
      expect(peep.id).to eq(persisted_data.first['id'])
      expect(peep.content).to eq('Testing testing')
      expect(peep.date).to eq('1/1/2022')
      expect(peep.time).to eq('00:00')
    end
  end

end
