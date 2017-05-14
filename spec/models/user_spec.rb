require 'rails_helper'

RSpec.describe User, type: :model do

	let(:recipe) { Recipe.create(name: "new recipe", directions: "ingredient directions", description: "yummy", ingredients: [ingredient2]) }
	let(:user) { User.create(email: "test@mail.com", password: "test1234") }
	let(:user2) { User.create(email: "test2@mail.com", password: "test1234") }
	let(:ingredient) { Ingredient.create(name: "carrot") }
	let(:ingredient2) { Ingredient.create(name: "steak") }

	describe "attributes" do

		it "has an email" do
			expect(user.email).to eq("test@mail.com")
		end

		it "is invalid without email" do
			@user = User.create
			expect(@user).to_not be_valid
		end

	end


	describe "associations" do
		
		it "knows about it's reviews from other users" do
			recipe.user = user
			recipe.save
			@comment = Comment.new(content: "comment")
			@comment.recipe = recipe
			@comment.save

			expect(user.reviews).to include(@comment)
		end

		it "has many comments" do 
			user.comments.create(content: "new comment")

			expect(user.comments.size).to eq(1)
		end

		it "has many ratings" do
			user.ratings.create(score: 5)

			expect(user.ratings.size).to eq(1)
		end

		it "knows about it's ratings from other users" do
			recipe.user = user
			recipe.save
	  	@rating = user2.ratings.create(score: 4, recipe_id: recipe.id)
	 		
	 		expect(user.received_ratings).to include(@rating)
			
		end

	end
end




