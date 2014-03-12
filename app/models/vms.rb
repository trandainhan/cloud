# == Schema Information
#
# Table name: vms
#
#  user_id        :integer          not null
#  vm_id          :integer          not null, primary key
#  hostname       :string(255)
#  vm_type        :integer          not null
#  state          :integer          default(0), not null
#  iso_id         :integer          default(1), not null
#  suffix_mac     :string(255)
#  ip             :string(255)
#  is_single      :boolean          default(FALSE), not null
#  is_group       :boolean          default(FALSE), not null
#  created_at     :datetime
#  expire_at      :datetime
#  is_activated   :integer          default(0), not null
#  allocated_vmid :integer
#

class Vms < ActiveRecord::Base
end
