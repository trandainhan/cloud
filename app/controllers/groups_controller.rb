class GroupsController < ApplicationController
	layout 'users_operation'
	def register
		#render trang single machine/register nhung co option cho chon so may
	end
	def create
		# lay id, type va so luong vm cua group roi dk voi server
		# hpcc_vms_register_group(username, pass, groupname, numVms, vmType) [GROUPNAME]
		# render trang index
	end
	def index
		# lay tat ca danh sach group cua user cho user chon
		# hpcc_vms_get_group_machine(username, pass)
		# get tat ca iso cho user chon
		# hpcc_vms_get_iso_group()
		# show ra cho user chon may nao chay
	end
	def start
		# khi user chon group de chay, get group_id, iso_id
		# hpcc_vms_start_group_machine(username, pass, groupid) [SAO K CO ISO_ID]
	end
	def stop
		# khi user chon group de stop, get group_id, iso_id
		# hpcc_vms_stop_group_machine(username, pass, groupid)
	end
	def handle_action
		
	end
end