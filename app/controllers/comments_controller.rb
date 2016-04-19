class CommentsController < ApplicationController
	load_and_authorize_resource :except => [:create]

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
		
		respond_to do |f|
			if @comment.save
				f.html { redirect_to recipe_path(@comment.recipe)}
				f.js { render action: 'create', status: :created, location: @comment }
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
