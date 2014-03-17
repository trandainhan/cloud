class MachinesController < ApplicationController
	layout 'users_operation'
	def register
		# get all vms_type from server
		response = hpcc_vms_get_type()
		@vm_list = response["ret"] == "OK" ? response["data"] : {}
	end

	def create
		# validate
		case params['machine_type']
		when '1' #single machine
			# get type(id) of vm and send to server
			vm_type = params["vm_id"]
			reg_response = hpcc_vms_register_single(current_user_name, current_user_password, 1, vm_type)
			if reg_response['ret'] == "OK"
				# get all vm of current user and redirect to index page
				getvm_response = hpcc_vms_get_single_machine(current_user_name, current_user_password)
				getiso_response = hpcc_vms_get_iso()
				if getvm_response['ret'] == "OK" && getiso_response['ret'] == 'OK'
					@user_vm_list = getvm_response["data"]
					@iso_list = getiso_response["data"]
				else
					# request failed, server error		
					@errors = "Get Virtual Machine Or ISO Image Failed"	
				end
			else
				# request failed, server error	
				@errors = "Register New Machine Failed: " + reg_response['errcode'].to_s 
			end
			redirect_to single_machines_index_path	
		when '2' #group
			reg_response = hpcc_vms_register_group(current_user_name, current_user_password, params["group_name"], params['group_num'], params['vm_id'])
			if reg_response['ret'] == "OK"
				# get all groups of current user and redirect to index page
				getgroup_response = hpcc_vms_get_group_machine(current_user_name, current_user_password)
				getiso_response = hpcc_vms_get_iso()
				if getgroup_response['ret'] == "OK" && getiso_response['ret'] == 'OK'
					@user_group_list = getgroup_response["data"]
					@iso_list = getiso_response["data"]
				else
					# request failed, server error		
					@errors = "Get Group Of Virtual Machine Or ISO Image Failed"	
				end
			else
				# request failed, server error	
				@errors = "Register New Machine Failed: " + reg_response['errcode'].to_s 
			end
			redirect_to groups_index_path
		end
	end

	def single_machine_index
		# get all vm of current user
		getvm_response = hpcc_vms_get_single_machine(current_user_name, current_user_password)
		# get all iso image
		getiso_response = hpcc_vms_get_iso()
		if getvm_response['ret'] == 'OK' && getiso_response['ret'] == 'OK'
			@user_vm_list = getvm_response["data"]	
			@iso_list = getiso_response["data"]
		else 
			# request failed, server error	
			@errors = "Get Virtual Machine Or ISO Image Failed"
		end
	end

	def single_machine_handle_action
		case params["commit"]
		when "Start"
			start_response = hpcc_vms_start_single_machine(current_user_name, current_user_password, params["vm_id"], params["iso_id"])	
			if start_response['ret'] == 'OK'
				#handle start
			else
				#show errors
			end
		when "Stop"
			stop_response = hpcc_vms_stop_single_machine(current_user_name, current_user_password, params["vm_id"])	
			if stop_response['ret'] == "OK"
				#handle stop
			else
				#show errors
			end
		when "Hibernate"	

		end
		redirect_to single_machines_index_path
	end
	
	def groups_index
		# get all groups of current user
		getgroup_response = hpcc_vms_get_group_machine(current_user_name, current_user_password)
		# get all iso image
		getiso_response = hpcc_vms_get_iso_group()
		if getgroup_response['ret'] == 'OK' && getiso_response['ret'] == 'OK'
			@user_group_list = getgroup_response["data"]	
			@iso_list = getiso_response["data"]
			# render json: @user_group_list
		else 
			# request failed, server error	
			@errors = "Get Group Of Virtual Machine Or ISO Image Failed"
		end
	end

	def groups_handle_action
		#validate
		case params['commit']
		when 'Start'
			start_response = hpcc_vms_start_group_machine(current_user_name, current_user_password, params['group_id'], params['iso_id'])
			if start_response['ret'] == 'OK'
				#handle start
				p "start ok"
			else	
				#show errors
				p "error:" + start_response['errcode']
			end
		when 'Stop'
			stop_response = hpcc_vms_stop_group_machine(current_user_name, current_user_password, params['group_id'])
			if stop_response['ret'] == 'OK'
							
			else
							
			end			
		when 'Hibernate'
		end
		redirect_to groups_index_path
	end

end