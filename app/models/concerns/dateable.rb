module Concerns::Dateable

	def dated
		order(created_at: :desc)
	end
end