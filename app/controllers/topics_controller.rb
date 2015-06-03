class TopicsController < ApplicationController
	
	
	def index
		@topics = Topic.all.order('created_at DESC')
	end

	def new
		@topic = Topic.new
	end

	def create
		@topic = Topic.new(topic_params)
		if @topic.save
			redirect_to @topic
		else
			render "new"
		end
	end

	def show
		@topic = Topic.find(params[:id])
	end

	def edit
		@topic = Topic.find(params[:id])
	end

	def update 
		@topic = Topic.find(params[:id])

		if @topic.update(params[:topic].permit(:name))
			redirect_to @topic
		else
			render 'edit'
		end
	end

	def destroy
		@topic = Topic.find(params[:id])
		@topic.destroy

		redirect_to root_path
	end


	private
		def topic_params

			params.require(:topic).permit(:name)
		end

		

end