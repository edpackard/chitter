feature 'navigation' do

  scenario 'User can sign-up and click New Peep button' do
    visit '/users/new'
    fill_in('name', with: 'chitterer123')
    fill_in('email', with: 'test@example.com')
    fill_in('password', with: 'drowsapp')
    click_button('Submit')
    click_link('New Peep')

    expect(page).to have_current_path('/peeps/new')
    expect(page).to have_no_link('New Peep')
  end

  scenario 'User can sign up, click New Peep button, and click See All Peeps button' do
    visit '/users/new'
    fill_in('name', with: 'chitterer123')
    fill_in('email', with: 'test@example.com')
    fill_in('password', with: 'drowsapp')
    click_button('Submit')

    click_link('New Peep')
    click_link('See All Peeps')

    expect(page).to have_current_path('/peeps')
    expect(page).to have_no_link('See All Peeps')
  end

  scenario 'User can sign up but not visit sign up page while signed in' do
    visit '/users/new'
    fill_in('name', with: 'chitterer123')
    fill_in('email', with: 'test@example.com')
    fill_in('password', with: 'drowsapp')
    click_button('Submit')
    
    visit '/users/new'

    expect(page).to have_current_path('/peeps')
  end

  scenario 'Unsigned-in user cannot visit new peeps page' do
    visit '/peeps/new'
    expect(page).to have_current_path('/peeps')
    expect(page).to have_no_link('New Peep')
  end

  scenario 'Unsigned-in user can see Sign Up link' do
    visit '/peeps'
    expect(page).to have_link('Sign Up')
  end
end
