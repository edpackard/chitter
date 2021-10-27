require 'peep'
require 'timecop'

describe Peep do

  describe '.all' do
    it 'returns all peeps' do
      time = Time.local(2022, 1, 1)
      Timecop.freeze(time)
      peep = Peep.create(content: 'This is a test peep.')
      Peep.create(content: 'This is another test peep.')
      Peep.create(content: 'Yet another test peep.')
      peeps = Peep.all
      p peep[0]
      expect(peeps.length).to eq 3
      expect(peeps.first).to be_a Peep
      expect(peeps.first.id).to eq(peep[0]['id'])
      expect(peeps.first.content).to eq('This is a test peep.')
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
