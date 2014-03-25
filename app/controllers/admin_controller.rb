class AdminController < ApplicationController
	layout "admin"
	before_action :signed_in_user, :signed_in_admin
	def virtual_machine
		@vms = VmType.all
		session[:active] = 'ad_vm'
	end
	def users
		@users = User.all
		session[:active] = 'ad_user'
	end
	def shift
		@shifts = Shift.all
		session[:active] = 'ad_shift'
	end
	def service_type
		@service_types = ServiceType.all
		session[:active] = 'ad_ser'
	end
	def iso_image
		@isos = Iso.all
		session[:active] = 'ad_iso'
	end
	def home
		session[:active] = 'ad_home'
	end

	def delete_shift
		@shift= Shift.find(params[:id])
  	if @shift.destroy
  		flash[:success] = "Successfully deleted..."
  	else
  		flash[:danger] = "Error! Can not delete object..."
		end
  	redirect_to '/admin/shift'
	end

	def delete_vm
		@vms = VmType.find(params[:id])
		if @vms.destroy
			flash[:success] = "Successfully deleted..."
		else
			flash[:danger] = "Error! Can not delete object..."
		end
  	redirect_to '/admin/virtual_machine'
	end

	def delete_user
		@user = User.find(params[:id])
		if @user.destroy
			flash[:success] = "Successfully deleted..."
		else
			flash[:danger] = "Error! Can not delete object..."
		end
		redirect_to '/admin/users'
	end

	def delete_iso
		@iso = Iso.find(params[:id])
		if @iso.destroy
			flash[:success] = "Successfully deleted..."
		else
			flash[:danger] = "Error! Can not delete object..."
		end
		redirect_to '/admin/iso_image'
	end

	def delete_service_type
		@service = ServiceType.find(params[:id])
		if @service.destroy
			flash[:success] = "Successfully deleted..."
		else
			flash[:danger] = "Error! Can not delete object..."
		end
		redirect_to '/admin/service_type'
	end
end