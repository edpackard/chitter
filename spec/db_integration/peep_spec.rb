require 'database_helpers'
require 'peep'
require 'timecop'

describe 'Peep: database integration' do

  describe '.all' do
    it 'retrieves peeps from database and displays them in reverse chronological order' do
      insert_user_into_db(name: 'TestUser1', password: 'drowssap', email: 'test@example.com')
      insert_user_into_db(name: 'TestUser2', password: 'password', email: 'test2@example.com')
      user1_id = get_user_id(name: 'TestUser1')
      user2_id = get_user_id(name: 'TestUser2')
    
      time = Time.utc(2022, 1, 1, 0, 0, 0)
      Timecop.freeze(time)
      peep = Peep.create(content: 'This is a test peep.', user_id: user1_id)
      
      time = Time.utc(2023, 1, 1, 0, 0, 0)
      Timecop.freeze(time)
      Peep.create(content: 'This is another test peep.', user_id: user2_id)
      
      time = Time.utc(2024, 1, 1, 0, 0, 0)
      Timecop.freeze(time)  
      Peep.create(content: 'Yet another test peep.', user_id: user2_id)
      
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
      
      insert_user_into_db(name: 'TestUser21', password: 'drowssap', email: 'test@example.com')
      user_id = get_user_id(name: 'TestUser21')
      
      peep = Peep.create(content: 'Testing testing', user_id: user_id)
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
