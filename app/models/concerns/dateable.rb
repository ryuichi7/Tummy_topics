module Concerns::Dateable
	def self.included(base)
		base.extend ClassMethods
		base.class_eval do
		  scope :disabled, -> { where(disabled: true) }
		end
	end

	module ClassMethods
		def dated
			order(created_at: :desc)
		end
	end

	def post_date
		created_at.strftime('%m/%d/%Y')
	end

end