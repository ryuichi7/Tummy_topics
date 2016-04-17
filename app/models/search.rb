class Search
	include ActiveModel::Model
	extend Concerns::Sortable
	attr_accessor :query

	def results
		if !@query.blank?
			Recipe.search(@query).alphabetized
		# 	validate_search(@results)
		# elsif !params[:rating].blank?
		# 	@results = Recipe.rating_search(params[:rating])
		# 	validate_search(@results)
		end
	end
end