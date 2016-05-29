class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :directions, :post_date, :image
  has_many :ratings
  has_many :comments
  has_one :user

  def image
  	object.image.url.tap do |image|
  		if image.match(/default_recipe_image|placeholder_image/)
  			return "/assets/#{image}"
  		end
  	end
  end
end
