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
end