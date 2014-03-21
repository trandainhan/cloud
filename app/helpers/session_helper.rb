module SessionHelper
	def current_user
		@current_user ||= User.find_by_username(session[:cloud_user])
	end

	def signed_in?
		!current_user.nil?
	end

	def admin_signed?
		current_user.role == 1 
	end

	def current_user? (user)
		user == current_user
	end

	def signed_in_user
		unless signed_in?
			store_location
			redirect_to users_sign_in_path, notice: "Please sign in"
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