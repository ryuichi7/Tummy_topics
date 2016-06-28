class Search
	include ActiveModel::Model
	extend Concerns::Sortable
	attr_accessor :query, :limit

	def results
		Recipe.search(@query, @limit).alphabetized if !@query.blank?
	end
end