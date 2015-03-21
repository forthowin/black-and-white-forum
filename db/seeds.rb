# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

bill = User.create(username: 'bill', password: 'password')

clan_war = Topic.create(title: 'Clan War', description: 'Talk strategy about current war.')
strat = Topic.create(title: 'Tactics and Strategy', description: 'Theorycraft base designs and attack compositions.')
general = Topic.create(title: 'General', description: 'Anything non clash related.')

Post.create(title: 'I need help with base design', body: 'My base is bad and need a rework, help!', user: bill, topic: strat)
Post.create(title: 'What is the best army comp', body: 'Is it Gowiwi?', user: bill, topic: strat)
Post.create(title: 'What do you guys think about this base?', body: 'Its pretty good i think.', user: bill, topic: strat)