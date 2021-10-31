require 'timecop'

feature 'Posting a new peep' do
  scenario 'A signed in user can post a peep to Chitter' do
    time = Time.utc(2022, 1, 1, 0, 0, 0)
    Timecop.freeze(time)

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
    expect(page).to have_content('Posted by chitterer123 on 1/1/2022 at 00:00')
  end

  scenario 'peep must be less than 140 characters' do
    visit '/users/new'
    fill_in('name', with: 'chitterer123')
    fill_in('email', with: 'test@example.com')
    fill_in('password', with: 'drowsapp')
    click_button('Submit')

    click_link('New Peep')
    fill_in('content', with: '123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901')
    click_button('Peep')
  
    expect(page).to have_current_path('/peeps/new')
    expect(page).to have_content "Peeps must be between 1-140 characters."
  end
end
