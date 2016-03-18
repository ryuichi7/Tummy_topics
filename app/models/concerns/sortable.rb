module Concerns
	module Concerns::Sortable

		def alphabetized
			order(:name)
		end
	end
end