require 'peep'

describe Peep do

  let(:connection) { double(:connection) }
  result = [ 
    {'content' => 'Test Peep 1'}, 
    {'content' => 'Test Peep 2'}, 
    {'content' => 'Test Peep 3'}
  ]

  it 'returns a list of peeps' do
    allow(PG).to receive(:connect).and_return(connection)
    allow(connection).to receive(:exec).and_return(result)
    peeps = Peep.all
    expect(peeps).to include 'Test Peep 1'
    expect(peeps).to include 'Test Peep 2'
    expect(peeps).to include 'Test Peep 3'
  end

end