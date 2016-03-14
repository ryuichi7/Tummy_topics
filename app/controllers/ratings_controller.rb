class RatingsController < ApplicationController

	def create
		@rating = Rating.create(rating_params)
		redirect_to recipe_path(@rating.recipe_id), notice: "Thanks for your rating!"
	end

	private

	def rating_params
		params.require(:rating).permit(:score, :rater_id, :recipe_id)
	end
end
