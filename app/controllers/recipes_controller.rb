class RecipesController < ApplicationController
	load_and_authorize_resource
	

	def index
		if params[:user_id]
			@recipes = User.find(params[:user_id]).recipes.alphabetized
		else
			@recipes = Recipe.alphabetized.limit(9).offset(params[:limit])
		end
		respond_to do |f|
			f.html { render :layout => 'recipe_index' }
		  f.json { render json: @recipes }
		end
	end

	def new
		@recipe = Recipe.new
	end

	def create
		@recipe = current_user.recipes.build(recipe_params)
		
		if @recipe.save
			redirect_to @recipe, flash: { success: "recipe successfully created" }
		else
			render new_recipe_path
		end
	end

	def show
		respond_to do |f|
			f.html { render :show }	
			f.json { render json: @recipe }
		end
	end

	def edit	
	end

	def update
		if @recipe.update(recipe_params)
			render json: @recipe, status: :created
		else
			render json: @recipe.errors, status: :unprocessable_entity
		end
	end


	def destroy
		@recipe.destroy
		redirect_to user_path(current_user), flash: { alert: "Your recipe has been deleted" }
	end


	private

	def recipe_params
		params.require(:recipe).permit(:name, :user_id, :description, :directions, :image, ingredients_attributes: [:name, :measurement])
	end

end
