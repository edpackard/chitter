require 'database_helpers'

describe '.create' do
  it 'creates new user' do
    user = User.create(name: 'TestUser21', password: 'drowssap', email: 'test@example.com')
    persisted_data = persisted_data(table: :users, id: user.id)
    expect(user.id).to eq persisted_data['id']
    expect(user.name).to eq('TestUser21')
    expect(user.email).to eq 'test@example.com'
    expect(user.password).to eq 'drowssap'
  end

describe '.find' do
  it 'finds a user by ID' do
    user = User.create(name: 'TestUser21', password: 'drowssap', email: 'test@example.com')
    result = User.find(user.id)
    expect(result.id).to eq user.id
    expect(result.email).to eq user.email
  end
end

end
