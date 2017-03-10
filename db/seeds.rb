# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

production = Production.create!(
  title: 'Macbeth',
  first_rehearsal: 1.day.from_now,
  last_rehearsal: 30.days.from_now,
  ios_code: '1234',
  ios_expiration: 7.days.from_now)

person_one = production.people.create!(
  first: 'Stephen',
  last: 'Kolison')

person_two = production.people.create!(
  first: 'Laura',
  last: 'Mosteller')

person_three = production.people.create!(
  first: 'Zach',
  last: 'Palumbo')

person_sm = production.people.create!(
  first: 'Jonah',
  last: 'Roth')

character_one = person_one.characters.create!(
  name: 'Macbeth')

character_two = person_two.characters.create!(
  name: 'Lady Macbeth')

character_three = person_three.characters.create!(
  name: 'Banquo')

conflict_one = person_one.conflicts.create!(
  start: 1.day.from_now,
  end: 1.day.from_now + 4.hours)

conflict_two = person_one.conflicts.create!(
  start: 2.days.from_now,
  end: 2.days.from_now + 1.hour,
  type: 'Conflicts::Weekly')

user_one = User.create!(
  email: 'jer135@case.edu',
  person: person_sm,
  password: 'supersecret',
  password_confirmation: 'supersecret')
