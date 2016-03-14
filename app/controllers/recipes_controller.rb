class RecipesController < ApplicationController

	def index
		if params[:search]
			@recipes = Recipe.search(params[:search])
		else
			@recipes = Recipe.all
		end
	end

	def search
		if params[:ingredient]
			@results = Recipe.ingredient_search(params[:ingredient])
		else params[:rating]
			@results = Recipe.rating_search(params[:rating])
		end
	end

	def new
		@recipe = Recipe.new
	end

	def create
		@recipe = Recipe.create(recipe_params)
		redirect_to @recipe
	end

	def show
		@recipe = Recipe.find(params[:id])
	end

	private

	def recipe_params
		params.require(:recipe).permit(:name, :user_id, :description, :directions, ingredient_attributes: [:ingredients])
	end

	# def check_for_duplicate_fields
	# 	if (params[:ingredient] && params[:rating]) || (params[:ingredient].empty? && params[:rating].empty?)
	# 		redirect_to :back, alert: 

end
