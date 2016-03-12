class Recipe < ActiveRecord::Base
	belongs_to :user
	has_many :recipe_ingredients
	has_many :ingredients, through: :recipe_ingredients
	has_many :comments
	has_many :ratings

	def ingredient_attributes=(ingredient_attributes)
		ingredient_attributes[:ingredients].split(/\r\n/).each do |ingredient|
			x = ingredient.split("-")
			measurment = x[0].strip
			ingr_name = x[1].strip
			i = Ingredient.find_or_create_by(name: ingr_name.downcase.singularize)
			if !self.ingredients.include?(i)
				self.recipe_ingredients.build(ingredient: i, measurement: measurment, name: ingr_name)
			end
		end
	end

	def directions_to_list
		directions.split(/\r\n/)
	end


end
