require 'net/http'
require 'json'
module ApplicationHelper
    RUN_ALONE   = "0"
    RUN_ON_SYS  = "1"	
    @@server_name 	= 'http://172.28.182.220:3000'
		@@mode = "0"
	def hpcc_register(username,pass)
		if(@@mode.to_i == RUN_ALONE.to_i)
			User.create!({username: username, activated: 1, role: 2})
			ret = {"ret"=>"OK","data"=>""} 
			return ret
		else
			uri = URI.parse(@@server_name)
			http = Net::HTTP.new(uri.host, uri.port)
			http.use_ssl = false
			request = Net::HTTP::Post.new("/user/register")
			data = {"username" => username.to_s, "password" => pass.to_s}
			data = data.to_json
			request.set_form_data({'data' => data})
			response = http.request(request)
			ret = JSON.parse(response.body)
			return ret
		end
	end
	def hpcc_signin(username,pass)
		if(@@mode.to_i == RUN_ALONE.to_i)
			puts @@mode
			puts RUN_ALONE
			puts "in sign in 1"
			session[:cloud_user] = username
			session[:cloud_pass] = pass

			ret = {"ret"=>"OK","errcode"=>"","data"=>""}
			# ret= {"ret" => "false"}
			return ret

			# return true
		else
			p 'zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz'
			uri = URI.parse(@@server_name)
			http = Net::HTTP.new(uri.host, uri.port)
			http.use_ssl = false
			request = Net::HTTP::Post.new("/user/authenticate")
			data = {"username" => username.to_s, "password" => pass.to_s}
			data = data.to_json
			request.set_form_data({'data' => data})
			response = http.request(request)
			ret = JSON.parse(response.body)
			if(ret["ret"] == "OK")
				session[:cloud_user] = username
				session[:cloud_pass] = pass
			end
			return ret
		end
	end
	def hpcc_signout()
		session[:cloud_user] = ''
		session[:cloud_pass] = ''
	end
	def hpcc_display_info
		ret = "servername is #{@servername.to_s} and my mode is #{@@mode.to_s},
		cloud user #{session[:cloud_user]},cloud pass #{session[:cloud_pass]}"
		return ret
	end


	def hpcc_vms_get_iso() # get iso cho may don
      	if(@@mode.to_i == RUN_ALONE.to_i)
			ret = {"ret"=>  "OK","errcode"=>  "","data"=> [
      				{"iso_id"=> "1","iso_name"=>  "CentOS_5_MPI"},
      				{"iso_id"=> "2","iso_name"=>  "CentOS_5_Hadoop"}]}
			return ret
		else
			uri = URI.parse(@@server_name)
			http = Net::HTTP.new(uri.host, uri.port)
			http.use_ssl = false
			request = Net::HTTP::Post.new("/vm/get/isolist/single")
			response = http.request(request)
			ret = JSON.parse(response.body)
			return ret
		end
	end

	def hpcc_vms_get_iso_group() # get iso cho group
      	if(@@mode.to_i == RUN_ALONE.to_i)
			ret = {"ret" => "OK","errcode" => "","data" => [{"iso_id" => 1,"iso_name" => "CentOS_5_MPI"},{"iso_id" => 2,"iso_name" => "CentOS_5_Hadoop"}]}
			return ret
		else
			uri = URI.parse(@@server_name)
			http = Net::HTTP.new(uri.host, uri.port)
			http.use_ssl = false
			request = Net::HTTP::Post.new("/vm/get/isolist/group")
			response = http.request(request)
			ret = JSON.parse(response.body)
			return ret
		end		
	end

	def hpcc_vms_get_single_machine(username, pass)  # lay danh sach may don cua 1 user
		if(@@mode.to_i == RUN_ALONE.to_i)
			ret = {	"ret"=>  "OK",
					"errcode"=>  "",
					"data"=> [
      					{"vm_id"=> 1,"vm_type"=> 1,
      						"state"=> "0","iso_id"=> "2"},
      					{"vm_id"=> 2,"vm_type"=> 2,
      						"state"=> "0","iso_id"=> "0"}]}
			return ret
		else
			uri = URI.parse(@@server_name)
			http = Net::HTTP.new(uri.host, uri.port)
			http.use_ssl = false
			request = Net::HTTP::Post.new("/vm/get/list/single")
			data = {"username" => username.to_s, "password" => pass.to_s}
			data = data.to_json
			request.set_form_data({'data' => data})
			response = http.request(request)
			ret = JSON.parse(response.body)
			if(ret["ret"] == "OK")
				session[:cloud_user] = username
				session[:cloud_pass] = pass
			end
			return ret

		end
	end

	def hpcc_vms_get_group_machine(username, pass) # lay danh sach group machine cua user
		if(@@mode.to_i == RUN_ALONE.to_i)
			ret = {"ret" => "OK","errcode" => "","data" => [{"group_id" => 1,"group_name" => "jc-test","numvms" => 2,"type_id" => 1,"iso_id" => 2,"state" => 2}]}
			return ret
		else
			uri = URI.parse(@@server_name)
			http = Net::HTTP.new(uri.host, uri.port)
			http.use_ssl = false
			request = Net::HTTP::Post.new("/vm/get/grouplist")
			data = {"username" => username.to_s, "password" => pass.to_s}
			data = data.to_json
			request.set_form_data({'data' => data})
			response = http.request(request)
			ret = JSON.parse(response.body)
			if(ret["ret"] == "OK")
				session[:cloud_user] = username
				session[:cloud_pass] = pass
			end
			return ret

		end		
	end

	def hpcc_vms_get_vms_of_group(username, pass, group_id)
		if(@@mode.to_i == RUN_ALONE.to_i)
			ret = {"ret" => "OK","errcode" => "","data" => [{"group_id" => 1,"group_name" => "jc-test","numvms" => 2,"type_id" => 1,"iso_id" => 2,"state" => 2}]}
			return ret
		else
			uri = URI.parse(@@server_name)
			http = Net::HTTP.new(uri.host, uri.port)
			http.use_ssl = false
			request = Net::HTTP::Post.new("/vm/get/groupvmlist")
			data = {"username" => username.to_s, "password" => pass.to_s, "groupid" => group_id}
			data = data.to_json
			request.set_form_data({'data' => data})
			response = http.request(request)
			ret = JSON.parse(response.body)
			if(ret["ret"] == "OK")
				session[:cloud_user] = username
				session[:cloud_pass] = pass
			end
			return ret
		end				
	end
	def hpcc_vms_get_type() # lay cac loai may ao
		if(@@mode.to_i == RUN_ALONE.to_i)
			ret = {   "ret"=> "OK",
				      "errcode"=>  "",
				      "data"=> [
				      {"id"=> 1,"name"=>  "'SMALL VM'"  ,"cpus"=> "1","ram"=> "2048"},
				      {"id"=> 2,"name"=>  "'MEDIUM VM'" ,"cpus"=> "2","ram"=> "4096"},
				      {"id"=> 3,"name"=>  "'LARGE VM'"  ,"cpus"=> "4","ram"=> "8192"},
				      {"id"=> 4,"name"=>  "'XTREME VM'" ,"cpus"=> "8","ram"=> "16384"}]}
			return ret
		else
			uri = URI.parse(@@server_name)
			http = Net::HTTP.new(uri.host, uri.port)
			http.use_ssl = false
			request = Net::HTTP::Post.new("/vm/get/types")
			request.set_form_data({'data' => ""})
			response = http.request(request)
			ret = JSON.parse(response.body)
			# if(ret['ret'] == "OK")
			# 	session[:cloud_user] = username
			# 	session[:cloud_pass] = pass
			# end
			return ret
		end
	end

	def hpcc_vms_register_single(username, pass, numVms, vmType)
		if (@@mode.to_i == RUN_ALONE.to_i)
			ret = {'ret' => 'OK', 'errcode' => '', 'data' => ''}
		else
			uri = URI.parse(@@server_name)
			http = Net::HTTP.new(uri.host, uri.port)
			http.use_ssl = false
			request = Net::HTTP::Post.new("/vm/register/single")
			data = {"username" => username.to_s, "password" => pass.to_s, "numVms" => numVms.to_s, "vmType" => vmType.to_s}
			data = data.to_json
			request.set_form_data({'data' => data})
			response = http.request(request)
			ret = JSON.parse(response.body)
			if(ret['ret'] == "OK")
				session[:cloud_user] = username
				session[:cloud_pass] = pass
			end
			return ret
		end
	end

	def hpcc_vms_register_group(username, pass, groupname, numVms, vmType)
		if (@@mode.to_i == RUN_ALONE.to_i)
			ret = {'ret' => 'OK', 'errcode' => '', 'data' => ''}
		else
			uri = URI.parse(@@server_name)
			http = Net::HTTP.new(uri.host, uri.port)
			http.use_ssl = false
			request = Net::HTTP::Post.new("/vm/register/group")
			data = {"username" => username.to_s, "password" => pass.to_s, "groupname" => groupname.to_s, "numVms" => numVms.to_s, 'vmType' => vmType.to_s}
			data = data.to_json
			request.set_form_data({'data' => data})
			response = http.request(request)
			ret = JSON.parse(response.body)
			if(ret['ret'] == "OK")
				session[:cloud_user] = username
				session[:cloud_pass] = pass
			end
			return ret
		end

	end

	def hpcc_vms_start_single_machine(username, pass, vm_id, isoid)
		if(@@mode.to_i == RUN_ALONE.to_i)
			ret = 	{"ret" => "OK","errcode" => "","data" => ""}
			return ret
		else
			uri = URI.parse(@@server_name)
			http = Net::HTTP.new(uri.host, uri.port)
			http.use_ssl = false
			request = Net::HTTP::Post.new("/vm/allocate/single")
			data = {"username" => username.to_s, "password" => pass.to_s, "vmid" => vm_id.to_s, "isoid" => isoid.to_s}
			data = data.to_json
			request.set_form_data({'data' => data})
			response = http.request(request)
			ret = JSON.parse(response.body)
			if(ret["ret"] == "OK")
				session[:cloud_user] = username
				session[:cloud_pass] = pass
			end
			return ret			
		end
	end

	def hpcc_vms_stop_single_machine(username, pass, vm_id)
		if(@@mode.to_i == RUN_ALONE.to_i)
			ret = 	{"ret" => "OK","errcode" => "","data" => ""}
			return ret
		else
			uri = URI.parse(@@server_name)
			http = Net::HTTP.new(uri.host, uri.port)
			http.use_ssl = false
			request = Net::HTTP::Post.new("/vm/shutdown/single")
			data = {"username" => username.to_s, "password" => pass.to_s, "vmid" => vm_id.to_s}
			data = data.to_json
			request.set_form_data({'data' => data})
			response = http.request(request)
			ret = JSON.parse(response.body)
			if(ret["ret"] == "OK")
				session[:cloud_user] = username
				session[:cloud_pass] = pass
			end
			return ret			
		end
	end

	def hpcc_vms_start_group_machine(username, pass, groupid, isoid)
		if(@@mode.to_i == RUN_ALONE.to_i)
			ret =  {"ret" => "OK","errcode" => "","data" => ""}
			return ret
		else
			uri = URI.parse(@@server_name)
			http = Net::HTTP.new(uri.host, uri.port)
			http.use_ssl = false
			request = Net::HTTP::Post.new("/vm/allocate/group")
			data = {"username" => username.to_s, "password" => pass.to_s, "groupid" => groupid.to_s, "isoid" => isoid.to_s}
			data = data.to_json
			request.set_form_data({'data' => data})
			response = http.request(request)
			ret = JSON.parse(response.body)
			if(ret["ret"] == "OK")
				session[:cloud_user] = username
				session[:cloud_pass] = pass
			end
			return ret			
		end
	end

	def hpcc_vms_stop_group_machine(username, pass, groupid)
		if(@@mode.to_i == RUN_ALONE.to_i)
			ret =  {"ret" => "OK","errcode" => "","data" => ""}
			return ret
		else
			uri = URI.parse(@@server_name)
			http = Net::HTTP.new(uri.host, uri.port)
			http.use_ssl = false
			request = Net::HTTP::Post.new("/vm/shutdown/group")
			data = {"username" => username.to_s, "password" => pass.to_s, "groupid" => groupid.to_s}
			data = data.to_json
			request.set_form_data({'data' => data})
			response = http.request(request)
			ret = JSON.parse(response.body)
			if(ret["ret"] == "OK")
				session[:cloud_user] = username
				session[:cloud_pass] = pass
			end
			return ret			
		end
	end

	#group
	def hpcc_group_get_iso()
      	if(@@mode.to_i == RUN_ALONE.to_i)
			ret = {"ret"=>  "OK","errcode"=>  "","data"=> [
      				{"iso_id"=> "1","iso_name"=>  "CentOS__group_5_MPI"},
      				{"iso_id"=> "2","iso_name"=>  "CentOS_group_5_Hadoop"}]}
			return ret
		else
			#ret = ret.to_json #convert to string
      		#ret = JSON.parse(ret) #convert to json
			uri = '/vm/get/isolist/group'
			data = ''
			data = data.to_json
			result = Net::HTTP.post(URI.parse(@@server_name,uri),data)
			return JSON.parse(result)
		end
	end	

	def get_class_from_vm_id(vm_id)
		case vm_id
		when 1
			'tiny'
		when 2
			'small'
		when 3
			'medium'
		when 4
			'pro'
		end
	end
end
