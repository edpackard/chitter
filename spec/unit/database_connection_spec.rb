require 'database_connection'

describe DatabaseConnection do

  let(:connection) { double(:connection) }

  describe '.setup' do
    it 'sets up connection to database (via PG)', :no_database_setup do
      expect(PG).to receive(:connect).with(dbname: 'chitter_test')
      DatabaseConnection.setup('chitter_test')
    end
  end

  describe '.connection' do
    it 'maintains a persistent connection', :no_database_setup do
      allow(PG).to receive(:connect).with(dbname: 'chitter_test').and_return(connection)
      DatabaseConnection.setup('chitter_test')
      expect(DatabaseConnection.connection).to eq connection
    end
  end

end