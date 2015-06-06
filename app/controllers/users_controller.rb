class UsersController < ApplicationController
before_filter :authenticate_user!,  :except => [:index]
load_and_authorize_resource
skip_authorize_resource :except => [:index, :show]
before_action :set_roles, only: [:new, :create, :edit, :update, :destroy]
before_action :set_user, only: [:show, :edit, :update]

	def new
	
	end

	def create
	
	end

	def edit
	end

	def update
    if user_params[:password].blank?
      user_params.delete(:password)
      user_params.delete(:password_confirmation)
    end 
    successfully_updated = if needs_password?(@user, user_params)
      @user.update(user_params)
    else
      @user.update_without_password(user_params)
    end 
    if successfully_updated
      flash[:notice] = 'Dane zostały zmienione'
      redirect_to @user
    else
      render action: 'edit'
    end
  end

	def show
		if @user.current_sign_in_at
			@last_login = @user.current_sign_in_at.to_formatted_s(:short)
		else
			@last_login = "nigdy"
		end
	end

	def index
		@users = User.all
	end



	def destroy
		@category = User.find(params[:id])
		@user.destroy

		redirect_to users_path
	end

	private

	def user_params
		params.require(:user).permit(:login, :password, :password_confirmation, :role_id, :email, :avatar)
	end

	def set_roles
		@roles = Role.all.map do |role|
		[role.name, role.id]
	    end
	end

	 def set_user
		@user = User.find(params[:id])
	 end

	def needs_password?(user, params)
		params[:password].present?
	end

end