# == Schema Information
#
# Table name: users
#
#  id        :integer          not null, primary key
#  username  :string(45)       not null
#  activated :boolean          default(FALSE), not null
#

class User < ActiveRecord::Base
  def get_vms
  	Vms.where(user_id: self.id)
  end
  def get_vms_logs()
		@user_vms_list = self.get_vms.map { |e| e.id }
		LeaseLog.where(vm_id: @user_vms_list)
	end
end
