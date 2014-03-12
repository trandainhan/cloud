# == Schema Information
#
# Table name: group_vms_mappings
#
#  id       :integer          not null, primary key
#  group_id :integer          not null
#  vm_id    :integer          not null
#

class GroupVmsMapping < ActiveRecord::Base
end
