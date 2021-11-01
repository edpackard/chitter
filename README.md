# Chitter Challenge

To add to README: planning diagrams, picture of app in action

[![Build Status](https://app.travis-ci.com/edpackard/chitter.svg?branch=main)](https://app.travis-ci.com/edpackard/chitter)
![Heroku](https://pyheroku-badge.herokuapp.com/?app=chitter-2021)

## Visit the deployed app

https://chitter-2021.herokuapp.com/

## Challenge:

To write a small Twitter clone that will allow the users to post messages to a public stream. See the [user stories](#user-stories) and [required functionality](#notes-on-functionality) below.

## Technologies used:

- Ruby 3.0.2

---

- Travis: continuous integration
- Heroku: deployment

---

- BCrypt: password encryption
- PostgreSQL: database
- Sinatra: web application microframework
- WEBrick: server

---

- Capybara: feature tests
- Rubocop: linting
- RSpec: unit and database integration tests
- SimpleCov: test coverage
- Timecop: freezing time for tests

## How to install this app

Run `gem install bundler` if required, then:

```
git clone https://github.com/edpackard/chitter.git
cd chitter
bundle install
```

## How to set up the database

1. Install and set up psql if required (Homebrew: `brew install postgresql`).
2. Connect to `psql` via the Terminal
3. Create the database using the psql command `CREATE DATABASE chitter;` and create the test database using the psql command `CREATE DATABASE chitter_test;`
4. Connect to the development database using the pqsl command `\c chitter;`
5. Sequentially run the queries saved in the `db/migrations` directory.
6. Connect to the test database using the psql command `\c chitter_test` and repeat step 5.

## How to use this app

From the `chitter` directory run `rackup` from the Terminal.

If rackup starts correctly, you should see a port number (i.e. `port=9292`)

Open a browser windows and enter http://localhost:9292/

The Chitter homepage will list all peeps that have been made so far - on a fresh installation, there won't be any peeps.

To get started, click Sign Up.

Enter your name, password, and email address.

Click Submit when you are ready.

If your details are accepted, you will receive a welcome message, and be returned to the main page. Click New Peep and a peep box will allow you to enter up to 140 characters of whatever is on your mind. When you are ready to peep, click Peep! You will see your peep appear in the peeps feed immediately. If you peep again, you will see your latest peep move to the top of the peeps feed.

If you want to peep with a different name, you will have to sign up again - but bear in mind there is currently no functionality that will allow you to sign back in with your previous 'account' (there is also currently no functionality to prevent identifical names signing up, so if you want to peep with the same name as before in a new session, you can sign up a new account with that name).

## How to run the tests

Run `rspec` from Terminal within the chitter-challenge directory. This will run all of the feature, integration and unit tests. To run individual tests, put the file path after rspec, such as `rspec ./spec/unit/user_spec.rb`

## User Stories:

Done:

```
STRAIGHT UP

As a Maker
So that I can let people know what I am doing
I want to post a message (peep) to chitter

As a maker
So that I can see what others are saying
I want to see all peeps in reverse chronological order

As a Maker
So that I can better appreciate the context of a peep
I want to see the time at which it was made

As a Maker
So that I can post messages on Chitter as me
I want to sign up for Chitter
```

To do:

```
HARDER

As a Maker
So that only I can post messages on Chitter as me
I want to log in to Chitter

As a Maker
So that I can avoid others posting messages on Chitter as me
I want to log out of Chitter

ADVANCED

As a Maker
So that I can stay constantly tapped in to the shouty box of Chitter
I want to receive an email if I am tagged in a Peep
```

## Notes on functionality:

- You don't have to be logged in to see the peeps.
  (done)
- Makers sign up to chitter with their email, password, name and a username (e.g. samm@makersacademy.com, password123, Sam Morgan, sjmog).
  (done, but need to implement username)
- The username and email are unique.
  (to do)
- Peeps (posts to chitter) have the name of the maker and their user handle.
  (to do - need to implement user handle)
- Your README should indicate the technologies used, and give instructions on how to install and run the tests.
  (done)

## Bonus:

If you have time you can implement the following:

- In order to start a conversation as a maker I want to reply to a peep from another maker.
  (to do)

And/Or:

- Work on the CSS to make it look good.
  (to do - basic CSS at moment, looks OK on mobile, less so on desktop)
