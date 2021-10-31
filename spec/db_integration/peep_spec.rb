require 'database_helpers'
require 'peep'
require 'timecop'

describe Peep do

  describe '.all' do
    it 'retrieves peeps from database and displays them in reverse chronological order' do
      user_1 = User.create(name: 'TestUser1', password: 'drowssap', email: 'test@example.com')
      persisted_user_1_data = persisted_data(id: user_1.id, table: :users)
      user_2 = User.create(name: 'TestUser2', password: 'password', email: 'test2@example.com')
      persisted_user_2_data = persisted_data(id: user_2.id, table: :users)
      
      time = Time.utc(2022, 1, 1, 0, 0, 0)
      Timecop.freeze(time)
      peep = Peep.create(content: 'This is a test peep.', user_id: persisted_user_1_data['id'])
      
      time = Time.utc(2023, 1, 1, 0, 0, 0)
      Timecop.freeze(time)
      Peep.create(content: 'This is another test peep.', user_id: persisted_user_2_data['id'])
      
      time = Time.utc(2024, 1, 1, 0, 0, 0)
      Timecop.freeze(time)  
      Peep.create(content: 'Yet another test peep.', user_id: persisted_user_2_data['id'])
      
      peeps = Peep.all

      expect(peeps.length).to eq 3
      expect(peeps.first).to be_a Peep
      expect(peeps.first.name).to eq('TestUser2')
      expect(peeps.last.id).to eq(peep.id)
      expect(peeps.last.content).to eq('This is a test peep.')
      expect(peeps.last.name).to eq('TestUser1')
    end

  end

  describe '.create' do
    it 'creates a new peep in the database' do
      time = Time.utc(2022, 1, 1, 0, 10, 0)
      Timecop.freeze(time)
      
      user = User.create(name: 'TestUser21', password: 'drowssap', email: 'test@example.com')
      persisted_user_data = persisted_data(id: user.id, table: :users)
      
      peep = Peep.create(content: 'Testing testing', user_id: persisted_user_data['id'])
      persisted_peep_data = persisted_data(id: peep.id, table: :peeps)
      
      expect(peep).to be_a Peep
      expect(peep.id).to eq(persisted_peep_data['id'])
      expect(peep.content).to eq('Testing testing')
      expect(peep.time).to eq('00:10')
      expect(peep.date).to eq('1/1/2022')
      expect(peep.name).to eq('TestUser21')
    end

  end

end
