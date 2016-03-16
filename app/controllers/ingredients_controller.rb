class IngredientsController < ApplicationController
	load_and_authorize_resource

	def index
		@ingredients = Ingredient.all
	end

	def show
		@ingredient = Ingredient.find(params[:id])
	end
end