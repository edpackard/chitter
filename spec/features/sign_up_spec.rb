feature 'sign up' do
  scenario 'a user can sign up' do
    visit '/users/new'
    fill_in('name', with: 'chitterer123')
    fill_in('email', with: 'test@example.com')
    fill_in('password', with: 'drowsapp')
    click_button('Submit')
    expect(page).to have_current_path('/peeps')
    expect(page).to have_content "Welcome, chitterer123"
  end
end
