module SessionHelper
	def current_user
		@current_user ||= User.find_by_username(session[:cloud_user])
	end

	def signed_in?
		!current_user.nil?
	end

	def admin_signed?
		p session[:cloud_user]
		p "###############################################"
		current_user.role == 1 
	end

	def current_user? (user)
		user == current_user
	end

	def signed_in_user
		unless signed_in?
			store_location
			flash[:danger] = "Please sign in"
			redirect_to users_sign_in_path 
		end
	end

	def signed_in_admin
		unless admin_signed?
			flash[:danger] = "You must have admin role to access admin page"
			redirect_to "/users/home"
		end
	end

	def store_location
    session[:return_to] = request.url
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def current_user_name
  	session[:cloud_user]
  end

  def current_user_password
  	session[:cloud_pass]
  end
end