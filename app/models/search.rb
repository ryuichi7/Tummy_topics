class Search
	# include ActiveModel

	def initialize(query)
		@query = query
	end

	def results
		if !@query.blank?
			@results = Recipe.ingredient_search(@query)
			validate_search(@results)
		elsif !params[:rating].blank?
			@results = Recipe.rating_search(params[:rating])
			validate_search(@results)
		end
	end
end