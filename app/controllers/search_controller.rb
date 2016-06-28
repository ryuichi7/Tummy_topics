class SearchController < ApplicationController
	

	def create
		puts params.inspect
		if params[:query].present?
			@search = Search.new(query: params[:query], limit: params[:limit])
			@results = @search.results
		else
			@results = Recipe.alphabetized.limit(9).offset(params[:limit])
		end
		render json: @results
	end

end