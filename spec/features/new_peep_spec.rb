feature 'Posting a new peep' do
  scenario 'A user can post a peep to Chitter' do
    visit('/peeps/new')
    expect(page).to have_field('content', placeholder: 'Write your peep here!')
    fill_in('content', with: 'A brand new peep!')
    click_button('Submit')
    expect(page).to have_current_path('/peeps')
    expect(page).to have_content('A brand new peep!')
  end
end
