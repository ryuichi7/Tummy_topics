class RecipesController < ApplicationController
	load_and_authorize_resource

	def index
		if !params[:search].blank?
			@recipes = Recipe.search(params[:search])
			validate_search(@recipes)
		else
			if params[:user_id]
				@recipes = User.find(params[:user_id]).recipes
			else
				@recipes = Recipe.all
			end
		end
	end

	def search
		if !params[:ingredient].blank?
			@results = Recipe.ingredient_search(params[:ingredient])
			validate_search(@results)
		elsif !params[:rating].blank?
			@results = Recipe.rating_search(params[:rating])
			validate_search(@results)
		end

	end

	def new
		@recipe = Recipe.new
	end

	def show	
	end

	def edit	
	end

	def update
		if @recipe.update(recipe_params)
			redirect_to @recipe, alert: "recipe successfully updated"
		else
			render :edit, alert: "please fill in all fields"
		end
	end


	def create
		@recipe = Recipe.new(recipe_params)
		if @recipe.save
			redirect_to @recipe
		else
			render new_recipe_path, alert: "please fill in all fields"
		end
	end

	def destroy
		@recipe.destroy
		redirect_to user_path(current_user), alert: "Your recipe has been deleted"
	end


	private

	def recipe_params
		params.require(:recipe).permit(:name, :user_id, :description, :directions, ingredient_attributes: [:ingredients])
	end

	def validate_search(results)
		if results.blank?
			redirect_to :back, alert: "Sorry no results found"
		end
	end



end
