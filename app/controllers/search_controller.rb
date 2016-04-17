class SearchController < ApplicationController
	# GET /search/new
	def new # our search form
	end

	# GET /search # /search?query=milk 
	def create # search result
		@search = Search.new(query: params[:query])
		@results = @search.results
		render json: @results
	end

end