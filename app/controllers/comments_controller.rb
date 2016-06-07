class CommentsController < ApplicationController
	load_and_authorize_resource

	def index
		if params[:user_id]
			@comments = User.find(params[:user_id]).comments.dated
		elsif params[:commenter_id]
			@reviews = User.find(params[:commenter_id]).reviews.dated
		else 
			@comments = Comment.dated
		end
	end

	def create
		@comment = current_user.comments.build(comment_params)
		
		respond_to do |f|
			if @comment.save
				f.html { redirect_to recipe_path(@comment.recipe)}
				f.js {}
			else
				f.html { redirect_to :back, alert: "please properly fill in comment field" }
				f.js { render json: @comment.errors, status: :unprocessable_entity }
			end
		end
	end

	def edit
	end

	def update
		if @comment.update(comment_params)
			redirect_to user_path(@comment.commenter), flash: { success: "successfully updated" }
		else
			render :edit, flash: { alert: "please fill in all fields" }
		end
	end

	def destroy
		@comment.destroy

		respond_to do |f|
			f.js {}
		end
	end


	private

	def comment_params
		params.require(:comment).permit(:content, :recipe_id)
	end

end
