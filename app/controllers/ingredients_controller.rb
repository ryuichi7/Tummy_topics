class IngredientsController < ApplicationController
	load_and_authorize_resource :except => [:new]

	def index
		@ingredients = Ingredient.alphabetized
	end

	def show
		@ingredient = Ingredient.find(params[:id])
	end

	def new
		render :new, layout: false
	end
end
