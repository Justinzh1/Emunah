# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(email: 'fake_seth@gmail.com', password: 'abcdef', full_name: 'Seth Martin', "role": 'admin')
User.create(email: 'wayne@gmail.com', password: 'abcdef', full_name: 'Wayne Li', "role": 'user')
User.create(email: 'joe@gmail.com', password: 'abcdef', full_name: 'Joe Law', "role": 'user')
User.create(email: 'Jackm@gmail.com', password: 'abcdef', full_name: 'Jack Mark', "role": 'user')
User.create(email: 'damon@gmail.com', password: 'abcdef', full_name: 'Damon Li', "role": 'user')
User.create(email: 'bob@gmail.com', password: 'abcdef', full_name: 'Bob Law', "role": 'user')
User.create(email: 'jan@gmail.com', password: 'abcdef', full_name: 'Jan Mark', "role": 'user')
User.create(email: 'dec@gmail.com', password: 'abcdef', full_name: 'Dec Li', "role": 'user')
User.create(email: 'mani@gmail.com', password: 'abcdef', full_name: 'Mani Law', "role": 'user')
User.create(email: 'Jann@gmail.com', password: 'abcdef', full_name: 'Jan Mark', "role": 'user')


f1 = Family.create({
	family_name: "Wayne and Seth",
	discovery: "Discovery A, Discovery B",
	hobbies: "Running, Reading",
	skills: "Cooking, Drawing",
	activities: "Skiing, Skydiving",
	committees: "Art",
	membership: "Member"
	})

s1f1 = f1.submittals.build({
	title: "Submittal A",
	family_name: f1.family_name,
	notes: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis urna libero, vestibulum id dui eu, semper euismod felis. Donec ornare neque ut sem dignissim, quis molestie nulla fringilla."
	})
s1f1.save!

s2f1 = f1.submittals.build({
	title: "Submittal B",
	family_name: f1.family_name,
	notes: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis urna libero, vestibulum id dui eu, semper euismod felis. Donec ornare neque ut sem dignissim, quis molestie nulla fringilla."
	})
s2f1.save!

s3f1 = f1.submittals.build({
	title: "Submittal C",
	family_name: f1.family_name,
	notes: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis urna libero, vestibulum id dui eu, semper euismod felis. Donec ornare neque ut sem dignissim, quis molestie nulla fringilla."
	})
s3f1.save!

s4f1 = f1.submittals.build({
	title: "Submittal D",
	family_name: f1.family_name,
	notes: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis urna libero, vestibulum id dui eu, semper euismod felis. Donec ornare neque ut sem dignissim, quis molestie nulla fringilla."
	})
s4f1.save!


f1p1 = f1.people.build({
	first_name: "Armando",
	last_name: "Fox",
	hebrew_name: "Hebrew Armando Fox",
	birthday: Date.today,
	home_address: "1234 Telegraph Ave",
	telephone: '1112221234',
	telephone_type: 'home',
	email_address: "Armando@gmail.com",
	employer: "Store A",
	occupation: "Clerk",
	anniversary: "1/1/2017",
	is_child: false,
	allow_contact: "Yes"
	})

f1p2 = f1.people.build({
	first_name: "Freeway",
	last_name: "Fox",
	hebrew_name: "Hebrew Armando Fox",
	birthday: Date.today,
	home_address: "1234 Telegraph Ave",
	telephone: '1112221234',
	telephone_type: 'home',
	email_address: "Armando@gmail.com",
	employer: "Store A",
	occupation: "Clerk",
	anniversary: "1/1/2017",
	is_child: false,
	allow_contact: "Yes"
	})

f1p1.save!
f1p2.save!

f2 = Family.create({
	family_name: "Wang",
	discovery: "Discovery A, Discovery B",
	hobbies: "Running, Reading",
	skills: "Cooking, Drawing",
	activities: "Skiing, Skydiving",
	committees: "Art",
	membership: "Member"
	})

f2p1 = f2.people.build({
	first_name: "Wesley",
	last_name: "Wang",
	hebrew_name: "Hebrew Armando Fox",
	birthday: Date.today,
	home_address: "1234 Telegraph Ave",
	telephone: '1112221234',
	telephone_type: 'home',
	email_address: "Armando@gmail.com",
	employer: "Store A",
	occupation: "Clerk",
	anniversary: "1/1/2017",
	is_child: false,
	allow_contact: "Yes"
	})

f2p2 = f2.people.build({
	first_name: "Ruowen",
	last_name: "Li",
	hebrew_name: "Hebrew Armando Fox",
	birthday: Date.today,
	home_address: "1234 Telegraph Ave",
	telephone: '1112221234',
	telephone_type: 'home',
	email_address: "Armando@gmail.com",
	employer: "Store A",
	occupation: "Clerk",
	anniversary: "1/1/2017",
	is_child: false,
	allow_contact: "Yes"
	})

f2p1.save!
f2p2.save!

f3 = Family.create({
	family_name: "Tilamok",
	discovery: "Discovery A, Discovery B",
	hobbies: "Running, Reading",
	skills: "Cooking, Drawing",
	activities: "Skiing, Skydiving",
	committees: "Art",
	membership: "Member"
	})

f3p1 = f3.people.build({
	first_name: "Casey",
	last_name: "Tilamok",
	hebrew_name: "Hebrew Armando Fox",
	birthday: Date.today,
	home_address: "1234 Telegraph Ave",
	telephone: '1112221234',
	telephone_type: 'home',
	email_address: "Armando@gmail.com",
	employer: "Store A",
	occupation: "Clerk",
	anniversary: "1/1/2017",
	is_child: false,
	allow_contact: "Yes"
	})

f3p2 = f3.people.build({
	first_name: "Peter",
	last_name: "Lee",
	hebrew_name: "Hebrew Armando Fox",
	birthday: Date.today,
	home_address: "1234 Telegraph Ave",
	telephone: '1112221234',
	telephone_type: 'home',
	email_address: "Armando@gmail.com",
	employer: "Store A",
	occupation: "Clerk",
	anniversary: "1/1/2017",
	is_child: false,
	allow_contact: "Yes"
	})

f3p1.save!
f3p2.save!

