require 'database_connection'

describe DatabaseConnection do

  let(:test_connection) { double(:test_connection) }
  let(:client_double) { double(:client_double) }

  describe '.setup' do
    it 'sets up connection to database', :no_database_setup do
      expect(client_double).to receive(:connect).with(dbname: 'chitter_test')
      DatabaseConnection.setup({dbname: 'chitter_test'}, client_double)
    end
  end

  describe '.query' do
    it 'sends sql queries to db connection', :no_database_setup do
      allow(client_double).to receive(:connect)
        .with(dbname: 'chitter_test').and_return(test_connection)
      DatabaseConnection.setup({ dbname: 'chitter_test' }, client_double)
      expect(test_connection).to receive(:exec_params).with("SELECT * FROM peeps;", [])
      DatabaseConnection.query("SELECT * FROM peeps;")
    end

    it 'sends params for an sql query to db connection', :no_database_setup do
      sql = "INSERT INTO peeps (content, timestamp) VALUES($1, $2) RETURNING id, content, timestamp;"
      allow(client_double).to receive(:connect)
        .with(dbname: 'chitter_test').and_return(test_connection)
      DatabaseConnection.setup({dbname: 'chitter_test'}, client_double)
      content = 'test peep'
      expect(test_connection).to receive(:exec_params)
        .with(sql, [content, Time.now])
      DatabaseConnection.query(sql, [content, Time.now])
    end
  end
end
