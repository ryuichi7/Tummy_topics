class SearchController < ApplicationController
	

	def create
		if params[:query].present?
			@search = Search.new(query: params[:query])
			@results = @search.results
		else
			@results = Recipe.all
		end
		render json: @results
	end

end