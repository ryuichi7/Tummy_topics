require 'rails_helper'

RSpec.describe 'recipe_serializer' do
	let(:recipe) { Recipe.create(name: "new recipe", directions: "ingredient directions", description: "yummy", ingredients: [ingredient3]) }
	let(:ingredient3) { Ingredient.create(name: "cheese") }

	context '.image' do
		it 'properly formats default image for json' do
			
			@recipe_serializer = RecipeSerializer.new(recipe)
			expect(@recipe_serializer.image).to eq "/assets/original/default_recipe_image.jpg" 
		end
	end
end
