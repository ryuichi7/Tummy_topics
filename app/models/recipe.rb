class Recipe < ActiveRecord::Base
	belongs_to :user
	has_many :recipe_ingredients, dependent: :destroy
	has_many :ingredients, through: :recipe_ingredients
	has_many :comments, dependent: :destroy
	has_many :ratings, dependent: :destroy
	validates_presence_of :name, :description, :directions
	extend Concerns::Sortable

	def ingredients_attributes=(ingredients)
		ingredients.each do |ingredient|
			ingr_name = ingredient[:name]
			measurement = ingredient[:measurement]

			i = Ingredient.find_or_create_by(name: ingr_name.downcase.singularize)
				
			if !self.ingredients.include?(i)
				self.recipe_ingredients.build(ingredient: i, measurement: measurement, name: ingr_name)
			end
		end
	end

	def directions_to_list
		directions.split(/\r\n/)
	end

	def self.search(params)
		where("name like ?", "%#{params.singularize}%") 
	end

	def self.ingredient_search(params)
		joins(:ingredients).where("ingredients.name like ?", "%#{params.singularize}%")
	end

	def self.rating_search(params)
		joins(:ratings).where(ratings: {score: params})
	end

	def rating_avg
		ratings.average(:score).round(2) unless ratings.average(:score).nil?
	end

	def user_name
		user.email_name.humanize
	end
	
end


