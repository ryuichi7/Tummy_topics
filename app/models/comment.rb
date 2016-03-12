class Comment < ActiveRecord::Base
	belongs_to :recipe
	belongs_to :commenter, class_name: "User"
	delegate :user, :to => :recipe, :allow_nil => true
end
