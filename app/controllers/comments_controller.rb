class CommentsController < ApplicationController
	before_action :authenticate_user!

	def create
		if !params[:comment][:content].empty?
			@comment = Comment.create(comment_params)
			redirect_to recipe_path(@comment.recipe), notice: "Thanks for your comment!"
		else
			redirect_to :back
		end
	end


	private

	def comment_params
		params.require(:comment).permit(:content, :recipe_id, :commenter_id)
	end

end
