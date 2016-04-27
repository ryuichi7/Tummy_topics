class RatingsController < ApplicationController
	load_and_authorize_resource

	def create
		@rating = current_user.ratings.build(rating_params)
		
		if @rating.save
			redirect_to recipe_path(@rating.recipe_id), flash: { success: "Thanks for your rating!" }
		else
			redirect_to :back, alert: "please select valid rating"
		end
	end

	private

	def rating_params
		params.require(:rating).permit(:score, :recipe_id)
	end
end
