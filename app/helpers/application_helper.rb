module ApplicationHelper

	def post_date(object)
		object.created_at.strftime('%m/%d/%Y')
	end

	def flash_class(level)
    case level
        when :notice then "alert alert-info"
        when :success then "alert alert-success"
        when :error then "alert alert-warning"
        when :alert then "alert alert-danger"
    end
	end

	
end
