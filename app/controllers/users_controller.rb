class UsersController < ApplicationController
	protect_from_forgery
	before_action :verify_login, only: [:show, :index]

	def home
	end

	def new
		@user = UserCustomer.new
	end

	def create
		@user = UserCustomer.new(user_params)
		if @user.save
			redirect_to login_path, :notice => "You successfully Signed up, Please login to continue!"
		else
			render 'new'
		end
	end

	def show
		@user = UserCustomer.find(params[:id])
	end

	def index
		@user = UserCustomer.all
	end

	def verify_login
		if !current_user
			if params[:user] && params[:user][:email] && params[:user][:password]
				@user = User.authenticate(params[:user][:email], params[:user][:password])
			end
			if @user
				session[:user_id] = @user.id
				redirect_to airplanes_url, :notice => "Logged in!"
			else
				flash.now.alert = "Invalid email or password" if params[:user]
				render "verify_login"
			end
		end
	end

	def password
	end

	def reset
		@user = User.find_by_email(params[:user][:email])
		if @user
			pass_code = SecureRandom.urlsafe_base64(6)
			@user.update_column(:reset_pass_code, pass_code)
			@link = "#{root_url}reset_link/#{pass_code}"
			NotificationMailer.reset_mailer(@user,@link).deliver rescue nil
			redirect_to login_path, :notice => "Email not received? follow this #{@link}"

		else
			render 'password'
			flash.now.alert = "No user found!" if params[:user][:email]
		end

	end

	def reset_link
		@user = User.find_by_reset_pass_code(params[:id])
	end

	def success_link
		@user = User.find_by_reset_pass_code(params[:user][:reset_code])
		if @user
			@user.password = params[:user][:confirm_password] if params[:user][:confirm_password]
			@user.save!
			#@user.update_column(:password, params[:user][:confirm_password]) if params[:user][:confirm_password]
			redirect_to login_path, :notice => "Your password successfully changed , Please log in!"

		end
	end

	def destroy_login
		session[:user_id] = nil
		redirect_to root_url, :notice => "Logged out!"
	end

	private
	
	def user_params
		params.require(:user).permit(:name, :email, :password, :confirm_password)
	end

end
