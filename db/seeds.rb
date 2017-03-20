# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Production.create!(title: 'Macbeth',
                   first_rehearsal: 7.days.ago,
                   last_rehearsal: 7.days.from_now)

Production.create!(title: 'Elektra',
                   first_rehearsal: 21.days.ago,
                   last_rehearsal: 7.days.ago)

Production.create!(title: 'Baby with the Bathwater',
                   first_rehearsal: 42.days.ago,
                   last_rehearsal: 21.days.ago)
