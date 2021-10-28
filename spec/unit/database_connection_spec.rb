require 'database_connection'

describe DatabaseConnection do

  let(:test_connection) { double(:test_connection) }

  describe '.setup' do
    it 'sets up connection to database (via PG)', :no_database_setup do
      expect(PG).to receive(:connect).with(dbname: 'chitter_test')
      DatabaseConnection.setup('chitter_test')
    end
  end

  describe '.connection' do
    it 'maintains a persistent connection', :no_database_setup do
      allow(PG).to receive(:connect).with(dbname: 'chitter_test').and_return(test_connection)
      DatabaseConnection.setup('chitter_test')
      expect(DatabaseConnection.connection).to eq(test_connection)
    end
  end

  describe '.query' do
    it 'sends sql queries to PG', :no_database_setup do
      allow(PG).to receive(:connect).with(dbname: 'chitter_test').and_return(test_connection)
      DatabaseConnection.setup('chitter_test')
      expect(test_connection).to receive(:exec_params).with("SELECT * FROM peeps;")
      DatabaseConnection.query("SELECT * FROM peeps;")
    end
  end

end