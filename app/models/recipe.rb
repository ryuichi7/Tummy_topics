class Recipe < ActiveRecord::Base
	belongs_to :user
	has_many :recipe_ingredients, dependent: :destroy
	has_many :ingredients, through: :recipe_ingredients
	has_many :comments, dependent: :destroy
	has_many :ratings, dependent: :destroy
	validates_presence_of :name, :description, :directions
	validate :ingredients_present?
	has_attached_file :image, default_url: ':style/default_recipe_image.jpg',
		styles: { original: '330x379#'}
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
	
	extend Concerns::Sortable
	include Concerns::Dateable

	def ingredients_attributes=(ingredients)
		recipe_ingredients.destroy_all if persisted?

		ingredients.each do |ingredient|
			unless ingredient[:name].blank?
				ingr_name = ingredient[:name]
				measurement = ingredient[:measurement]

				i = Ingredient.find_or_create_by(name: ingr_name.downcase.singularize)
					
				if !ingredients.include?(i)
					recipe_ingredients.build(ingredient: i, measurement: measurement, name: ingr_name)
				end
			end
		end
	end

	def directions_to_list
		directions.split(/\r\n/)
	end

	def self.search(params)
		if params.match(/^[1-5]$/)
			p = params.to_i
			select("recipes.*, AVG(ratings.score) AS average_score").joins(:ratings)
			.group('recipes.id').having('average_score BETWEEN ? and ?', p, p + 0.99)
		else
			joins(:ingredients)
			.where("ingredients.name like :params OR recipes.name like :params", params: "%#{params.singularize}%").uniq
		end 
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

	private

	def ingredients_present?
		errors.add(:ingredients_attributes, "recipe must have ingredients") if recipe_ingredients.empty?
	end
	
end


