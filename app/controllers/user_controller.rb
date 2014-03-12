class UserController < ApplicationController
	def new
		
	end

	def create
		if(params[:username] && params[:password]) #if username and password not null
			result = hpcc_register(params[:username], params[:password])# send request to server
			if result[:ret] == "OK"
				#register successful, redirect to homepage

			else
				#flash errors
			end
		else
			#flash errors
		end
	end

	def edit
		
	end

	def update
		
	end

	def delete
		
	end

end
