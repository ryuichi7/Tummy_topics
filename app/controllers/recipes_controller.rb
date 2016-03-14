class RecipesController < ApplicationController

	def index
		if params[:search]
			@recipes = Recipe.search(params[:search])
		else
			@recipes = Recipe.all
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
		# @comment = @recipe.comments.build
	end

	private

	def recipe_params
		params.require(:recipe).permit(:name, :user_id, :description, :directions, ingredient_attributes: [:ingredients])
	end
end
