class AdminController < ApplicationController
	layout "admin"
	def virtual_machine
		@vms = VmType.all
	end
	def users
		@users = User.all
	end
	def shift
		@shifts = Shift.all
	end
	def service_type
		@service_types = ServiceType.all
	end
	def iso_image
		@isos = Iso.all
	end
	def home
		
	end
end