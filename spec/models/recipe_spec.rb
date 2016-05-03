require 'rails_helper'


RSpec.describe Recipe, type: :model do
 
	let(:recipe) { Recipe.create(name: "new recipe", directions: "ingredient directions", description: "yummy", ingredients: [ingredient3]) }
	let(:recipe2) { Recipe.create(name: "another recipe", directions: "cook it up", description: "tasty", ingredients: [ingredient3]) }
	let(:user) { User.create(email: "test@mail.com", password: "test1234") }
	let(:ingredient) { Ingredient.create(name: "carrot") }
	let(:ingredient2) { Ingredient.create(name: "steak") }
	let(:ingredient3) { Ingredient.create(name: "cheese") }

	
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

			expect(recipe.recipe_ingredients.size).to eq(2)
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
			
			expect(Recipe.search("carrot")).to include(recipe)
			expect(Recipe.search("another recipe")).to include(recipe2)

		end
	end

	describe "validations" do
		it "validates presence of ingredients" do
			@recipe = Recipe.create(name: "cheesecake")
			error_message = "Ingredients attributes recipe must have ingredients"
			expect(@recipe).to_not be_valid
			expect(@recipe.errors.full_messages_for(:ingredients_attributes)).to include(error_message)

		end
	end


	  

end
