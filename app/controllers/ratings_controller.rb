class RatingsController < ApplicationController
	load_and_authorize_resource

	def create
		@rating = Rating.new(rating_params)
		
		if @rating.save
			redirect_to recipe_path(@rating.recipe_id), notice: "Thanks for your rating!"
		else
			redirect_to :back, alert: "please select valid rating"
		end
	end

	private

	def rating_params
		params.require(:rating).permit(:score, :rater_id, :recipe_id)
	end
end
