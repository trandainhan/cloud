# == Schema Information
#
# Table name: lease_logs
#
#  id           :integer          not null, primary key
#  vm_id        :integer          not null
#  start_time   :datetime
#  stop_time    :datetime
#  isTerminated :integer          default(0), not null
#  run_time     :datetime
#  price        :float            default(0.0), not null
#

class LeaseLog < ActiveRecord::Base
	def update_run_time
		@run_time = ((self.stop_time - self.start_time)/3600).round(3)
		return true if self.update_attributes!({run_time: @run_time})
		false
	end
	def update_price_per_hour(price)
		return true if self.update_attributes!({price_per_hour: price})
		false
	end
	def update_total_price
		price = self.price_per_hour * run_time
		return true if self.update_attributes!({total_price: price})
		false
	end
	def update_iso_id
		iso_id= Vms.find(self.vm_id).iso_id
		return true if self.update_attributes!({iso_id: iso_id})	
		false
	end
end
