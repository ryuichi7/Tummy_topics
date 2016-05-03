class Search
	include ActiveModel::Model
	extend Concerns::Sortable
	attr_accessor :query

	def results
		Recipe.search(@query).alphabetized if !@query.blank?
	end
end