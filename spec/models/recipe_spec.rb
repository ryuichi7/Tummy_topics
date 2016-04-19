require 'rails_helper'


RSpec.describe Recipe, type: :model do
 
	let(:recipe) { Recipe.create(name: "new recipe", directions: "ingredient directions", description: "yummy") }
	let(:recipe2) { Recipe.create(name: "another recipe", directions: "cook it up", description: "tasty") }
	let(:user) { User.create(email: "test@mail.com", password: "test1234") }
	let(:ingredient) { Ingredient.create(name: "carrot") }
	let(:ingredient2) { Ingredient.create(name: "steak") }

	
	describe "recipe attributes" do

		it "has a name" do
			expect(recipe.name).to eq("new recipe")
		end

		it "has directions" do
			expect(recipe.directions).to eq("ingredient directions")
		end

	end

	describe "associations" do

		it "belongs to a user" do
			recipe.user = user
			recipe.save

			expect(recipe.user).to eq(user)
		end

		it "has many recipe_ingredients" do
			recipe.recipe_ingredients.create

			expect(recipe.recipe_ingredients.size).to eq(1)
		end

		it "has many ingredients" do
			recipe.ingredients << [ingredient, ingredient2]
			recipe.save

			expect(recipe.ingredients).to include(ingredient)
		end

		it "destroys dependents when destroyed" do
			comment = recipe.comments.create(content: "new comment")
			recipe.destroy

			expect(Comment.last).to_not eq(comment)
		end

	end

	describe 'search methods' do
		it "can find recipes by name or name of ingredient" do
			recipe.ingredients << [ingredient, ingredient2]
			recipe2.ingredients << [ingredient, ingredient2]
			recipe.reload
			recipe2.reload

			expect(Recipe.ingredient_search("carrot")).to include(recipe)
			expect(Recipe.ingredient_search("another recipe")).to include(recipe2)

		end
	end


	  

end
