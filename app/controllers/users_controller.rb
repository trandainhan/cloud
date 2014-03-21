class UsersController < ApplicationController
	before_action :signed_in_user, only: [:home, :show, :edit, :update, :delete, :history]
	layout 'users_operation'
	include FormValidationHelper
	def new
		render layout: "application"
	end

	def new_session
		render layout: "application"
	end

	def create_session
		if params["username"] && params[:password]
			signin_response = hpcc_signin(params[:username], params[:password])# send request to server
			if signin_response["ret"] == "OK"
				# redirect to user page
				redirect_to '/users/home'
			else
				#error
				render text: "errors: "+ signin_response["errcode"]
			end	
		else
			@errors = "Username or password is incorrect"
			render 'new_session'
		end
		
	end

	def delete_session
		hpcc_signout()
		redirect_to root_path, notice: "Sign out successful"
	end

	def create
		is_validated = validation(params[:username], params[:password], params[:password_confirmation])
		if is_validated[:ret]
			reg_response = hpcc_register(params[:username], params[:password])# send request to server
			if reg_response["ret"] == "OK"
				#register successful, sign in user and redirect to user page
				signin_response = hpcc_signin(params[:username], params[:password])# send request to server
				if signin_response["ret"] == "OK"
					# redirect to user page
					render 'home'
				else
					#error
					render text: "errors: "+ signin_response["errcode"]
				end
			else
				#render 500 Internal Error
				render text: "500 Internal Error: " + reg_response['errcode']
			end
		else
			@errors = is_validated[:detail]
			render 'new'
		end
	end

	def home
		session[:active] = 'home'
	end

	def show
		
	end

	def edit
		
	end

	def update
		
	end

	def delete
		
	end

	def history
		session[:active] = 'history'
	end

end
