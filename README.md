# Chitter Challenge

## Technologies used:

Ruby 3.0.2
Rubocop
RSpec
SimpleCov

## Challenge:

To write a small Twitter clone that will allow the users to post messages to a public stream.

## How to install this app

```
git clone https://github.com/edpackard/chitter.git
```

## How to set up the database

1. Install and set up psql if required (Homebrew: `brew install postgresql`).
2. Connect to `psql` via the Terminal
3. Create the database using the psql command `CREATE DATABASE chitter;` and create the test database using the psql command `CREATE DATABASE chitter_test;`
4. Connect to the development database using the pqsl command `\c chitter;`
5. Run the query saved in the file `db/migrations/01_create_peeps_table.sql`
6. Connect to the test database using the psql command `\c chitter_test` and repeat step 5.

## How to run this app

## How to use this app

## How to run the tests

```
cd chitter
rspec
```

## User Stories:

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
- Makers sign up to chitter with their email, password, name and a username (e.g. samm@makersacademy.com, password123, Sam Morgan, sjmog).
- The username and email are unique.
- Peeps (posts to chitter) have the name of the maker and their user handle.
- Your README should indicate the technologies used, and give instructions on how to install and run the tests.

## Bonus:

If you have time you can implement the following:

- In order to start a conversation as a maker I want to reply to a peep from another maker.

And/Or:

- Work on the CSS to make it look good.

## Progress Log

- first step: cloned the repo, tidied up README, ran bundle install, checked RSpec, rubocop, simplecov all working
- planned simple routes/db relationships and MVC diagrams for 'straight up' user stories
