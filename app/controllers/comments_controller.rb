class CommentsController < ApplicationController
	load_and_authorize_resource

	def index
		if params[:user_id]
			@comments = User.find(params[:user_id]).comments
		elsif params[:commenter_id]
			@reviews = User.find(params[:commenter_id]).reviews
		else 
			@comments = Comment.all
		end
	end

	def create
		@comment = Comment.new(comment_params)
		if @comment.save
			redirect_to recipe_path(@comment.recipe), alert: "Thanks for your comment!"
		else
			redirect_to :back, alert: "please properly fill in comment field"
		end
	end

	def edit
		
	end

	def update
		if @comment.update(comment_params)
			redirect_to user_path(@comment.commenter), alert: "successfully updated"
		else
			render :edit, alert: "please fill in all fields"
		end
	end

	def destroy
		@comment.destroy
		redirect_to recipes_path, alert: "comment successfully destroyed"
	end


	private

	def comment_params
		params.require(:comment).permit(:content, :recipe_id, :commenter_id)
	end

end
