module PricingHelper
	# update machine cost
	def update_machine_cost
		VmType.all.each do |m|
			new_cost = machine_cost(m.id)[:ret] == 'OK' ? machine_cost(m.id)[:data] : m.price
			m.update_attributes({price: new_cost})
		end
	end
	# calculate cost of a single machine only
	def machine_cost(machine_id)
		machine_ratio= VmType.find(machine_id).ratio
		unit_value = ServiceType.find_by_name('machine').unit_value
		if machine_ratio.present? &&  unit_value.present?
			{ret: "OK", data: machine_ratio * unit_value}
		else
			{ret: "Error"}
		end
	end

	# total cost of a single machine includes cost of the iso image it uses
	def total_cost(machine_id, iso_id)
		machine_cost = machine_cost(machine_id)
		iso_ratio = Iso.find(iso_id).ratio
		if machine_cost[:ret] == "OK" && iso_ratio.present?
			{ret: "OK", data: machine_cost[:data]*iso_ratio}
		else
			{ret: "Error"}
		end
	end

	# calculate cost of storage only
	def storage_cost(storage_id)
		
	end

	# update storage ratio base on it's capacity
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

	# calculate cost of datatransfer, under implementation
	def datatransfer_cost(datatransfer_id)
		
	end

	def present_cost(total_cost)
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

	# => cost on demand or reserved
	def method_name
		
	end
end