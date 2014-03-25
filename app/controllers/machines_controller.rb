class MachinesController < ApplicationController
	before_action :signed_in_user
	layout 'users_operation'
	def register
		session[:active] = 'register'
		#update machine price
		update_machine_cost
		# get all vms_type from server
		response = hpcc_vms_get_type()
		@vm_list = response["ret"] == "OK" ? response["data"] : {}
	end

	def create
		# validate
		if params['machine_type']
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
						flash[:danger] = "Get Virtual Machine Or ISO Image Failed: " + getvm_response["errcode"]	+ getiso_response['errcode']
						render "register"
					end
				else
					# request failed, server error	
					flash[:danger] = "Register New Machine Failed: " + reg_response['errcode'].to_s 
					render "register"
				end
				flash[:success] = "Register Single Machine Successful!"
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
						flash[:danger] = "Get Group Of Virtual Machine Or ISO Image Failed"	+ getvm_response["errcode"]	+ getiso_response['errcode']
						render "register"
					end
				else
					# request failed, server error	
					flash[:danger] = "Register New Machine Failed: " + reg_response['errcode'].to_s 
					render "register"
				end
				flash[:success] = "Register Group Machine Successful!"
				redirect_to groups_index_path
			end
		else
			flash[:danger] = "You must choose one machine type" 
			render "register"
		end
	end

	def single_machine_index
		session[:active] = 'single'
		# get all vm of current user
		getvm_response = hpcc_vms_get_single_machine(current_user_name, current_user_password)
		# get all iso image
		getiso_response = hpcc_vms_get_iso()
		if getvm_response['ret'] == 'OK' && getiso_response['ret'] == 'OK'
			@user_vm_list = getvm_response["data"]	
			@iso_list = getiso_response["data"]
		else 
			# request failed, server error	
			flash[:danger] = "Get Virtual Machine Or ISO Image Failed" + getvm_response["errcode"]	+ getiso_response['errcode']
		end
	end

	def single_machine_handle_action
		case params["commit"]
		when "Start"
			start_response = hpcc_vms_start_single_machine(current_user_name, current_user_password, params["vm_id"], params["iso_id"])	
			if start_response['ret'] == 'OK'
				#handle start
				flash[:success] = "Successfully started"
			else
				#show errors
			end
		when "Stop"
			stop_response = hpcc_vms_stop_single_machine(current_user_name, current_user_password, params["vm_id"])	
			if stop_response['ret'] == "OK"
				#handle stop
				flash[:success] = "Successfully stopped"
			else
				#show errors
			end
		when "Hibernate"	

		end
		redirect_to single_machines_index_path
	end
	
	def groups_index
		session[:active] = 'groups'
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
			flash[:danger] = "Get Group Of Virtual Machine Or ISO Image Failed" + getvm_response["errcode"]	+ getiso_response['errcode']
		end
	end

	def groups_handle_action
		#validate
		case params['commit']
		when 'Start'
			start_response = hpcc_vms_start_group_machine(current_user_name, current_user_password, params['group_id'], params['iso_id'])
			if start_response['ret'] == 'OK'
				#handle start
				flash[:success] = "Successfully started"
			else	
				#show errors
				flash[:danger] = "Error:" + start_response['errcode']
			end
		when 'Stop'
			stop_response = hpcc_vms_stop_group_machine(current_user_name, current_user_password, params['group_id'])
			if stop_response['ret'] == 'OK'
				flash[:success] = "Successfully stopped"			
			else
				flash[:danger] = "Error:" + start_response['errcode']			
			end			
		when 'Hibernate'
		end
		redirect_to groups_index_path
	end

	def get_iso_price
		if params[:vm_id] && params[:iso_id]
			ret = total_cost(params[:vm_id], params[:iso_id])
			@price =  ret[:ret] == 'OK' ? ret[:data] : "error"
			render text: @price.to_s
		else
			render text: "error"
		end
	end

end