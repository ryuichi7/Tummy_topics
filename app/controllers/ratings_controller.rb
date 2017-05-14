class RatingsController < ApplicationController
	load_and_authorize_resource

	def create
		@rating = current_user.ratings.build(rating_params)

		if @rating.save
			render json: @rating, status: :created
		else
			render json: @rating.errors, status: :unprocessable_entity
		end
	end

	private

	def rating_params
		params.require(:rating).permit(:score, :recipe_id)
	end
end
