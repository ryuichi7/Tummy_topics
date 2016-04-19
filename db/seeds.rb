# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

10.times do 
	User.create(
		email: Faker::Internet.email,
		password: Faker::Internet.password
		)
end


30.times do
	Ingredient.create(
		name: Faker::Commerce.product_name
		)
end

30.times do
	Recipe.create(
		name: Faker::Lorem.word,
		description: Faker::Lorem.paragraph,
		directions: Faker::Lorem.paragraph,
		user: User.find(rand(1..10)),
		ingredients_attributes: [*1..4].collect { Ingredient.find(rand(1..30)) }
	)
end

30.times do 
	Comment.create(
		content: Faker::Lorem.paragraph,
		commenter: User.find(rand(1..10)),
		recipe: Recipe.find(rand(1..30))
		)
end

30.times do 
	Rating.create(
		score: rand(1..5),
		rater: User.find(rand(1..10)),
		recipe: Recipe.find(rand(1..30))
	)
end

Recipe.all.each do |recipe|
	recipe.comments << [*1..4].collect { Comment.find(rand(1..30)) }
	recipe.ratings << [*1..4].collect { Rating.find(rand(1..30)) }
end

