require 'timecop'

feature 'Viewing peeps' do

  scenario 'visit index page' do

    time = Time.local(2022, 1, 1)
    Timecop.freeze(time)
    Peep.create(content: 'This is a test peep.')
    time = Time.local(2023, 1, 1)
    Timecop.freeze(time)
    Peep.create(content: 'This is another test peep.')
    time = Time.local(2024, 1, 1)
    Timecop.freeze(time)
    Peep.create(content: 'Yet another test peep.')

    visit('/peeps')
    expect(page).to have_content "This is a test peep."
    expect(page).to have_content "Posted on 1/1/2022 at 00:00"
    expect(page).to have_content "This is another test peep."
    expect(page).to have_content "Posted on 1/1/2023 at 00:00"
    expect(page).to have_content "Yet another test peep."
    expect(page).to have_content "Posted on 1/1/2024 at 00:00"
  end
end
