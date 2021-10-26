require 'pg'

feature 'Viewing peeps' do
  scenario 'visit index page' do
    connection = PG.connect(dbname: 'chitter_test')
    connection.exec("INSERT INTO peeps (content) VALUES ('This is a test peep.');")
    connection.exec("INSERT INTO peeps (content) VALUES ('This is another test peep.');")
    connection.exec("INSERT INTO peeps (content) VALUES ('Yet another test peep.');")

    visit('/peeps')
    expect(page).to have_content "This is a test peep."
    expect(page).to have_content "This is another test peep."
    expect(page).to have_content "Yet another test peep."
  end
end