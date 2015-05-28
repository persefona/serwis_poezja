class CategoriesController < ApplicationController
	
	
	def index
		@categories = Category.all.order('created_at DESC')
	end

	def new
		@category = Category.new
	end

	def create
		@category = Category.new(post_params)
		if @category.save
			redirect_to @category
		else
			render "new"
		end
	end

	def show
		@category = Category.find(params[:id])
	end

	def edit
		@category = Category.find(params[:id])
	end

	def update 
		@category = Category.find(params[:id])

		if @category.update(params[:category].permit(:title))
			redirect_to @category
		else
			render 'edit'
		end
	end

	def destroy
		@category = Category.find(params[:id])
		@category.destroy

		redirect_to root_path
	end


	private
		def post_params

			params.require(:category).permit(:title)
		end

		

end