class PostsController < ApplicationController
	before_action :authenticate_user!, only: [:add, :edit, :update, :new, :destroy]
	
	 before_action :set_post, only: [:show, :edit, :update, :destroy]
	

	def index
		@posts = Post.all.order('created_at DESC')
	end

	def new
		@post = Post.new
		@categories = Category.all.map do |category| 
    		[category.title, category.id] 
		end
		@topics = Topic.all.map do |topic| 
	    		[topic.name, topic.id] 
		end
    end

	def create
		
		@post = Post.new(post_params)
		@post.user_id = current_user.id

			@categories = Category.all.map do |category| 
    		[category.title, category.id] 
		end
		@topics = Topic.all.map do |topic| 
	    		[topic.name, topic.id] 
		end

		if @post.save

		flash[:notice]="Post został dodany!"
        redirect_to posts_path
       
		else
			 render :action => 'new'
			
		end
	end

	def show
		@post = Post.find(params[:id])
		
	end

	def edit
		@post = Post.find(params[:id])
		@categories = Category.all.map do |category| 
    		[category.title, category.id] 
		end
		@topics = Topic.all.map do |topic| 
	    		[topic.name, topic.id] 
		end
		authorize! :update, @post
	end

	def update 
		@post = Post.find(params[:id])

			@categories = Category.all.map do |category| 
    		[category.title, category.id] 
		end
		@topics = Topic.all.map do |topic| 
	    		[topic.name, topic.id] 
		end

		if @post.update(params[:post].permit(:title, :body, :category_id, :topic_id))
			redirect_to @post
		else
			render 'edit'
		end
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy

		redirect_to current_user
	end


	private
		def post_params

			params.require(:post).permit(:title, :body, :category_id, :topic_id, :user_id)

		end

		 def set_post
			@post = Post.find(params[:id])
		end
				
	 end

	


 


