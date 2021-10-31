feature 'Posting a new peep' do
  scenario 'A user can post a peep to Chitter' do
    visit '/users/new'
    fill_in('name', with: 'chitterer123')
    fill_in('email', with: 'test@example.com')
    fill_in('password', with: 'drowsapp')
    click_button('Submit')
    click_link('New Peep')
    expect(page).to have_field('content', placeholder: 'Write your peep here!')
    fill_in('content', with: 'A brand new peep!')
    click_button('Peep!')
    expect(page).to have_current_path('/peeps')
    expect(page).to have_content('A brand new peep!')
  end
end
