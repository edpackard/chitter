feature 'Viewing peeps' do
  scenario 'visit index page' do
    visit('/peeps')
    expect(page).to have_content "This is a test peep!"
    expect(page).to have_content "This is another test peep!"
    expect(page).to have_content "Yet another test peep."
  end
end