# == Schema Information
#
# Table name: group_vm_requests
#
#  id             :integer          not null, primary key
#  user_id        :integer          not null
#  groupname      :string(255)
#  num_vm_request :integer          not null
#  vm_type        :integer          not null
#  need_process   :integer          default(1), not null
#  is_granted     :integer          default(0), not null
#  created_at     :datetime         not null
#  updated_at     :datetime
#

class GroupVmRequest < ActiveRecord::Base
end
