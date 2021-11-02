require 'database_helpers'

describe 'User: database integration' do

  describe '.create' do
    it 'creates new user in the database' do
      user = User.create(name: 'TestUser21', password: 'drowssap', email: 'test@example.com')
      persisted_data = persisted_data(table: :users, id: user.id)
      
      expect(user.id).to eq(persisted_data['id'])
      expect(user.name).to eq('TestUser21')
      expect(user.email).to eq('test@example.com')
    end
  end

  describe '.find' do
    it 'finds user in the database by ID' do
      user = User.create(name: 'TestUser21', password: 'drowssap', email: 'test@example.com')
      result = User.find(user.id)
      
      expect(result.id).to eq(user.id)
      expect(result.email).to eq(user.email)
    end
  end
end
