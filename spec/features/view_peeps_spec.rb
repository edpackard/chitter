require 'timecop'

feature 'Viewing peeps' do

  scenario 'visit index page' do

    visit '/users/new'
    fill_in('name', with: 'chitterer123')
    fill_in('email', with: 'test@example.com')
    fill_in('password', with: 'drowsapp')
    click_button('Submit')

    time = Time.utc(2022, 1, 1, 0, 0, 0)
    Timecop.freeze(time)
    click_link('New Peep')
    fill_in('content', with: 'This is a test peep.')
    click_button('Peep!')

    time = Time.utc(2023, 1, 1, 0, 0, 0)
    Timecop.freeze(time)
    click_link('New Peep')    
    fill_in('content', with: 'This is another test peep.')
    click_button('Peep!')
    
    time = Time.utc(2024, 6, 1, 0, 0, 0)
    Timecop.freeze(time)
    click_link('New Peep')
    fill_in('content', with: 'A test peep posted within BST.')
    click_button('Peep!')

    visit('/peeps')
    
    expect(page).to have_content "This is a test peep."
    expect(page).to have_content "Posted by chitterer123 on 1/1/2022 at 00:00"
    expect(page).to have_content "This is another test peep."
    expect(page).to have_content "Posted by chitterer123 on 1/1/2023 at 00:00"
    expect(page).to have_content "A test peep posted within BST."
    expect(page).to have_content "Posted by chitterer123 on 1/6/2024 at 01:00"
  end
end
