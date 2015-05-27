class UsersController < ApplicationController
before_filter :authenticate_user!
load_and_authorize_resource
before_action :set_roles, only: [:new, :create, :edit, :update]
before_action :set_user, only: [:show, :edit, :update]

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			flash[:notice]="Rejestracja przebiegła pomyślnie!"
			redirect_to users_path
		else
			render :action => 'new'
		end
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

	private

	def user_params
		params.require(:user).permit(:login, :password, :password_confirmation, :role_id, :email)
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