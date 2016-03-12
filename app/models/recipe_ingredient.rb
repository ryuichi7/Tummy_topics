class RecipeIngredient < ActiveRecord::Base
	belongs_to :recipe
	belongs_to :ingredient

	def ingredient_name
		ingredient.name.humanize
	end
end
