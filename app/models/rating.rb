class Rating < ActiveRecord::Base
	belongs_to :recipe
	belongs_to :rater, class_name: "User"
	delegate :user, to: :recipe, allow_nil: true
end
