# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Topic.create(title: 'General', description: 'Anything non clash related.')
Topic.create(title: 'Clan War', description: 'Talk strategy about current war.')
Topic.create(title: 'Tactics and Strategy', description: 'Theorycraft base designs and attack compositions.')
Topic.create(title: 'Introductions', description: 'Introduce yourself!')
Topic.create(title: 'Clan Application', description: 'Want to join Black and White? Post why you should be recruited!')
Topic.create(title: 'Suggestions', description: 'Got an idea on how to impove the clan or the website? Post here!')


# thread1 = Subject.create(title: 'I need help with base design', body: 'My base is bad and need a rework, help!', user: bill, topic: strat)
# thread2 = Subject.create(title: 'What is the best army comp', body: 'Is it Gowiwi?', user: bill, topic: strat)
# thread3 = Subject.create(title: 'What do you guys think about this base?', body: 'Its pretty good i think.', user: bill, topic: strat)

# Post.create(body: 'yeah its pretyt oasd foasdfoasd foasdfj oas fos fasf aosdf.', user: bill, subject: thread2)
# Post.create(body: 'yasdfasdf eah its pretyt oasd foasdfoasd foasdfj oas fos fasf aosdf.', user: bill, subject: thread2)
# Post.create(body: 'yesdfah its pretysdft oasd foassa dfasfdfdfoa asdfasdsd foasdfj oas fos fasf aosdf.', user: bill, subject: thread2)