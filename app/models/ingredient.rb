class Ingredient < ActiveRecord::Base
	has_many :recipe_ingredients
	has_many :recipes, through: :recipe_ingredients	
	extend Concerns::Sortable
end


# possible refactor? use delimited_description in tandem with nested_attributes macro 
# to move ingredient parsing in to ingredient model and create new find_or_create method for ingredient

# attr_accessor :delimited_description # Bypass the form

# 	def self.find_or_create_by_delimited_description(delimited_description)
# 		Ingredient.find_or_create_by(name: parse_delimited_description(delimited_description).downcase.singularize)
# 	end

# 	private 
# 		def self.parse_delimited_description(delimited_description)
# 			x = delimited_description.split("-")
# 			measurment = x.first.strip
# 			ingr_name = x.last.strip
# 		end