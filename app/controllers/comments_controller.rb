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
		@comment = Comment.new(comment_params)
		@comment.commenter = current_user
		@comment.save

		respond_to do |f|
			f.js { flash.now[:notice] = "Thanks for your comment!" }
			f.html { redirect_to recipe_path(@comment.recipe)}
		end
	# 		# redirect_to recipe_path(@comment.recipe), alert: "Thanks for your comment!"
	# 		render json: @comment, status: 201
	# 	# else
	# 	# 	redirect_to :back, alert: "please properly fill in comment field"
	# 	# end
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

		respond_to do |f|
			f.js { flash.now[:alert] = "comment successfully destroyed" }
		end
		# redirect_to recipes_path, alert: "comment successfully destroyed"
	end


	private

	def comment_params
		params.require(:comment).permit(:content, :recipe_id)
	end

end
