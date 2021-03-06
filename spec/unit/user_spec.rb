require 'user'

describe User do

  let(:connection) { double :connection }

  describe '.create' do

    response = [
      { 
        "id" => '1', "name" => 'Test', 
        "email" => 'test@example.com', "password" => 'drowsapp' 
      }
    ]

    it 'creates a new user', :no_database_setup do
      allow(connection).to receive(:query).and_return(response)
      user = User.create(name: 'Test', email: 'test@example.com', password: 'drowsapp', connection: connection)
      expect(user.id).to eq('1')
      expect(user.name).to eq('Test')
      expect(user.email).to eq('test@example.com')
    end

    it 'hashes password using BCrypt', :no_database_setup do
      allow(connection).to receive(:query).and_return(response)
      expect(BCrypt::Password).to receive(:create).with('drowsapp')
      User.create(name: 'Test', email: 'test@example.com', password: 'drowsapp', connection: connection)
    end

    it 'will not allow usernames above 15 characters', :no_database_setup do
      expect(connection).to_not receive(:query)
      User.create(name: 'Toolongname12345', email: 'test@example.com', password: 'drowsapp', connection: connection)
    end
    
    it 'will not allow empty usernames', :no_database_setup do
      expect(connection).to_not receive(:query)
      User.create(name: '', email: 'test@example.com', password: 'drowsapp', connection: connection)
    end

    it 'will not allow passwords above 140 characters', :no_database_setup do
      expect(connection).to_not receive(:query)
      User.create(name: 'name', email: 'test@example.com', password: '123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901', connection: connection)
    end
    
    it 'will not allow empty password', :no_database_setup do
      expect(connection).to_not receive(:query)
      User.create(name: 'name', email: 'test@example.com', password: '', connection: connection)
    end

    it 'will not allow email above 60 characters', :no_database_setup do
      expect(connection).to_not receive(:query)
      User.create(name: 'name', email: 'testtesttesttesttesttesttesttesttesttesttesttest1@example.com', password: 'drowsapp', connection: connection)
    end
    
    it 'will not allow empty email', :no_database_setup do
      expect(connection).to_not receive(:query)
      User.create(name: 'name', email: '', password: 'drowsapp', connection: connection)
    end

  end

  describe '.find' do

    result = [
      { 
        "id" => "10", 
        "name" => "Test User", 
        "email" => "email@example.com",
      }
    ]

    it 'returns user based on id', :no_database_setup do
      allow(connection).to receive(:query).and_return(result)
      user = User.find("10", connection)
      expect(user.id).to eq("10")
      expect(user.name).to eq("Test User")
      expect(user.email).to eq("email@example.com")
    end

    it 'returns nil if no id passed', :no_database_setup do
      expect(User.find(nil, connection)).to eq nil
    end
  end
end
