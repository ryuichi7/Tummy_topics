class SearchController < ApplicationController
	# GET /search/new
	def new # our search form
	end

	# GET /search # /search?query=milk 
	def create # search result
		if params[:query].present?
			@search = Search.new(query: params[:query])
			@results = @search.results
		else
			@results = Recipe.all
		end
		render json: @results
	end

end