class SearchController < ApplicationController

	# GET /search/new
	def new # our search form
	end

	# GET /search # /search?query=milk 
	def create # search result
		@search = Search.new(params[:query])
		@results = @search.results
	end

end