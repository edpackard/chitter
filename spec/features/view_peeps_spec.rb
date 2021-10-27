feature 'Viewing peeps' do
  scenario 'visit index page' do
    Peep.create(content: 'This is a test peep.')
    Peep.create(content: 'This is another test peep.')
    Peep.create(content: 'Yet another test peep.')

    visit('/peeps')
    expect(page).to have_content "This is a test peep."
    expect(page).to have_content "This is another test peep."
    expect(page).to have_content "Yet another test peep."
  end
end