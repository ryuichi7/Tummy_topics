class Search
	include ActiveModel::Model
	extend Concerns::Sortable
	attr_accessor :query

	def results
		if !@query.blank?
			Recipe.search(@query).alphabetized
		end
	end
end