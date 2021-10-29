feature 'navigation' do
  scenario 'A user can click on a button in index to go to new post page' do
    visit('/peeps')
    click_button('New Peep')
    expect(page).to have_current_path('/peeps/new')
    expect(page).to have_no_button 'New Peep'
  end

  scenario 'A user can click on a button on new post page to go to index' do
    visit('/peeps/new')
    click_button('See All Peeps')
    expect(page).to have_current_path('/peeps')
    expect(page).to have_no_button 'See All Peeps'
  end

end