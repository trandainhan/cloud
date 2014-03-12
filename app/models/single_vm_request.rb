# == Schema Information
#
# Table name: single_vm_requests
#
#  id             :integer          not null, primary key
#  user_id        :integer          not null
#  num_vm_request :integer          not null
#  vm_type        :integer          not null
#  need_process   :boolean          default(TRUE), not null
#  is_granted     :boolean          default(FALSE), not null
#  created_at     :datetime         not null
#  updated_at     :datetime
#

class SingleVmRequest < ActiveRecord::Base
end
