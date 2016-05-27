class Comment < ActiveRecord::Base
	belongs_to :recipe
	belongs_to :commenter, class_name: "User"
	delegate :user, :to => :recipe, :allow_nil => true
	validates_presence_of :content
	include Concerns::Dateable
	

	def recipe_name
		recipe.name.titleize
	end
end
