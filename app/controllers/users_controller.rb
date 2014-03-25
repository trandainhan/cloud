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
		if params[:username] && params[:password]
			signin_response = hpcc_signin(params[:username], params[:password])# send request to server
			if signin_response["ret"] == "OK"
				# redirect to user page
				flash[:success] = "Welcome back #{params[:username]}"
				redirect_to '/users/home'
			else
				#error
				flash[:danger] = "Error: #{signin_response["errcode"]}"
				render 'new_session', layout: "application"
			end	
		else
			flash[:danger] = "Username or password is incorrect"
			render 'new_session', layout: "application"
		end
		
	end

	def delete_session
		hpcc_signout()
		# flash[:success]= "Sign out successful"
		redirect_to root_path
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
					flash[:success] = "Welcome, #{params[:username]}"
					redirect_to '/users/home'
				else
					#error
					flash[:danger] = "Error: #{signin_response["errcode"]}"
					render 'new_session', layout: "application"
				end
			else
				#render 500 Internal Error
				flash[:danger] = "Error: #{reg_response['errcode']}"
				render 'new', layout: "application"
			end
		else
			flash[:danger] = is_validated[:detail]
			render 'new', layout: "application"
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
