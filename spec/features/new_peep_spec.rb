feature 'Posting a new peep' do
  scenario 'A user can post a peep to Chitter' do
    visit('/peeps/new')
    fill_in('content', with: 'A brand new peep!')
    click_button('Submit')
    expect(page).to have_content('A brand new peep!')
    # update for time
  end
end
