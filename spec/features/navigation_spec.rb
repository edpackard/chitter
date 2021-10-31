feature 'navigation' do
  scenario 'A signed-in user can click on a button in index to go to new post page' do
    visit '/users/new'
    fill_in('name', with: 'chitterer123')
    fill_in('email', with: 'test@example.com')
    fill_in('password', with: 'drowsapp')
    click_button('Submit')
    click_link('New Peep')
    expect(page).to have_current_path('/peeps/new')
    expect(page).to have_no_link 'New Peep'
  end

  scenario 'A signed-in user can click on a button on new peep page to go to index' do
    visit '/users/new'
    fill_in('name', with: 'chitterer123')
    fill_in('email', with: 'test@example.com')
    fill_in('password', with: 'drowsapp')
    click_button('Submit')
    click_link('New Peep')
    click_link('See All Peeps')
    expect(page).to have_current_path('/peeps')
    expect(page).to have_no_link 'See All Peeps'
  end

  scenario 'A signed-in user cannot vist sign up page' do
    visit '/users/new'
    fill_in('name', with: 'chitterer123')
    fill_in('email', with: 'test@example.com')
    fill_in('password', with: 'drowsapp')
    click_button('Submit')
    visit '/users/new'
    expect(page).to have_current_path('/peeps')
  end

  scenario 'An unsigned-in user cannot visit new peeps page' do
    visit '/peeps/new'
    expect(page).to have_current_path('/peeps')
    expect(page).to have_no_link('New Peep')
  end

  scenario 'An unsigned-in user will see the sign up link' do
    visit '/peeps'
    expect(page).to have_link('Sign Up')
  end

end
