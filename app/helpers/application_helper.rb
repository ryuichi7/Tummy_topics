module ApplicationHelper

	def post_date(object)
		object.created_at.strftime('%m/%d/%Y')
	end

end
