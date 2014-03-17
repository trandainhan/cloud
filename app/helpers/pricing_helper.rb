module PricingHelper
	# => calculate cost of a single machine only
	def machine_cost(machine_id)
		machine_ratio= Machine.find(machine_id).ratio
		unit_value = ServiceType.find_by_type_service('machine').unit_value
		if machine_ratio.present? &&  unit_value.present?
			machine_ratio * unit_value 
		else
			0
		end
	end

	#= calculate cost of storage only
	def storage_cost(storage_id)
		set_storage_ratio # update_storage_ratio
		storage_ratio= Storage.find(storage_id).ratio
		unit_value = ServiceType.find_by_type_service('storage').unit_value
		if storage_ratio.present? &&  unit_value.present?
			storage_ratio * unit_value
		else
			0
		end
	end

	# => update storage ratio base on it's capacity
	def set_storage_ratio
		unit_value = ServiceType.find_by_type_service('storage').unit_value
		Storage.all.each do |s|
			if s.value < 5
				s.update_attributes!({ratio: s.value * unit_value})
			else
				s.update_attributes!({ratio: s.value * unit_value * 0.8})
			end
		end
	end

	# => calculate cost of datatransfer, under implementation
	def datatransfer_cost(datatransfer_id)
		return 0
	end

	# => total cost, or image cost
	def total_cost(image)
		os_ratio = 1
		if image.operating_system_id.present?
			r = OperatingSystem.find(image.operating_system_id).ratio # => find os ratio
			os_ratio= r unless r.nil?
		end
		machine_cost(image.machine_id)*os_ratio + storage_cost(image.storage_id)+ datatransfer_cost(image.data_transfer_id)
	end

	def present_cost(image)
		total_cost= total_cost(image)
		blue_shift_start= Time.parse(Shift.blue_shift_start)
		blue_shift_end= Time.parse(Shift.blue_shift_end)
		@transaction= current_user.transactions.where(image_id = image.id).last
		start= @transaction.starttime
		stop=  @transaction.stoptime
		used_time = (stop - start)/3600
		if start >= blue_shift_start && stop <= blue_shift_end
			return total_cost* 0.8 * used_time
		elsif start < blue_shift_start && stop.between?(blue_shift_start, blue_shift_end)
			out_blue_time = (blue_shift_start - start)/3600
			in_blue_time = (stop - blue_shift_start)/3600
			return total_cost* 0.8 * in_blue_time + total_cost * out_blue_time
		elsif start.between?(blue_shift_start, blue_shift_end) && stop > blue_shift_end	
			out_blue_time = (stop - blue_shift_end)/3600
			in_blue_time = (blue_shift_end - start)/3600
			return total_cost* 0.8 * in_blue_time + total_cost * out_blue_time
		end
		return total_cost * used_time
	end

	# => update static image cost base on db
	def update_static_image_cost
		StaticImage.all.each do |i|
			i.update_attributes!({cost: total_cost(i)})
		end
	end

	# => cost on demand or reserved
	def method_name
		
	end
end