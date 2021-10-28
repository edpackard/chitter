require 'database_connection'

describe DatabaseConnection do

  let(:test_connection) { double(:test_connection) }

  describe '.setup' do
    it 'sets up connection to database (via PG)', :no_database_setup do
      expect(PG).to receive(:connect).with(dbname: 'chitter_test')
      DatabaseConnection.setup(dbname: 'chitter_test')
    end
  end

  describe '.query' do
    it 'sends sql queries to PG', :no_database_setup do
      allow(PG).to receive(:connect).with(dbname: 'chitter_test').and_return(test_connection)
      DatabaseConnection.setup({dbname: 'chitter_test'})
      expect(test_connection).to receive(:exec_params).with("SELECT * FROM peeps;", [])
      DatabaseConnection.query("SELECT * FROM peeps;")
    end

    it 'can send params for an sql query', :no_database_setup do
      allow(PG).to receive(:connect).with(dbname: 'chitter_test').and_return(test_connection)
      DatabaseConnection.setup(dbname: 'chitter_test')
      content = 'test peep'
      expect(test_connection).to receive(:exec_params).with("INSERT INTO peeps (content, timestamp) VALUES($1, $2) RETURNING id, content, timestamp;", [content, Time.now])
      DatabaseConnection.query("INSERT INTO peeps (content, timestamp) VALUES($1, $2) RETURNING id, content, timestamp;", [content, Time.now])

    end
  end

end