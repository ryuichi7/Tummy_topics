module RecipesHelper
	def authorize_links_to_edit_and_destroy(object)
		link_to "edit", edit_recipe_path(object) if can? :update, object
		link_to "delete", recipe_path(object), method: "DELETE" if can? :destroy, object
	end

end
