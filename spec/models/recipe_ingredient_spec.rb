require 'rails_helper'

RSpec.describe RecipeIngredient, type: :model do

	let(:recipe_ingredient) { FactoryGirl.create(:recipe_ingredient) }
	let(:recipe) { FactoryGirl.create(:recipe) }
	let(:ingredient) { FactoryGirl.create(:ingredient) }

	describe "attributes" do
		it "has a measurement" do
			expect(recipe_ingredient.measurement).to eq("1 cup")
		end

		it "has a name" do
			expect(recipe_ingredient.name).to eq("salt")
		end
	end

	describe "associations" do
		it "belongs to recipe" do
			recipe.recipe_ingredients.build(ingredient: ingredient)

			expect(recipe_ingredient.recipe).to eq(recipe)
		end

		it "belongs to an ingredient" do
			recipe_ingredient.ingredient = ingredient

			expect(recipe_ingredient.ingredient).to eq(ingredient)
		end
	end


  

end
