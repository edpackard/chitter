feature 'navigation' do
  scenario 'A user can click on a button in index to go to new post page' do
    visit('/peeps')
    click_button('New Peep')
    expect(page).to have_current_path('/peeps/new')
  end
end