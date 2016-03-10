require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  

	let(:recipe) { Recipe.create(name: "new recipe", directions: "ingredient directions", cost: 50) }
	let(:user) { User.create(email: "test@mail.com", password: "test1234") }
	let(:ingredient) { Ingredient.create(name: "carrot", price: 0.75) }
	let(:ingredient2) { Ingredient.create(name: "steak", price: 18.50) }


	describe "ingredient attributes" do

		it "has a name" do
			expect(ingredient.name).to eq("carrot")
		end

		it "has a price" do
			expect(ingredient.price).to eq(0.75)
		end
	end

	describe "associations" do

		it "has many recipe_ingredients" do
			ingredient.recipe_ingredients.create

			expect(ingredient.recipe_ingredients.size).to eq(1)
		end

		it "has many recipes" do
			ingredient.recipes << recipe
			ingredient.save

			expect(ingredient.recipes).to include(recipe)
		end
	end
end
