require 'user'

describe User do

  describe '.create' do

    response = [
      { 
        "id" => '1', "name" => 'Test', 
        "email" => 'test@example.com', "password" => 'drowsapp' 
      }
    ]

    it 'creates a new user', :no_database_setup do
      allow(DatabaseConnection).to receive(:query).and_return(response)
      user = User.create(name: 'Test', email: 'test@example.com', password: 'drowsapp')
      expect(user.id).to eq('1')
      expect(user.name).to eq('Test')
      expect(user.email).to eq('test@example.com')
    end

    it 'hashes password using BCcrypt', :no_database_setup do
      allow(DatabaseConnection).to receive(:query).and_return(response)
      expect(BCrypt::Password).to receive(:create).with('drowsapp')
      User.create(name: 'Test', email: 'test@example.com', password: 'drowsapp')
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
      allow(DatabaseConnection).to receive(:query).and_return(result)
      user = User.find("10")
      expect(user.id).to eq("10")
      expect(user.name).to eq("Test User")
      expect(user.email).to eq("email@example.com")
    end

    it 'returns nil if no id passed', :no_database_setup do
      expect(User.find(nil)).to eq nil
    end
  end

end
