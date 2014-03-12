# == Schema Information
#
# Table name: group_users_mappings
#
#  group_id  :integer          not null
#  user_id   :integer          not null
#  is_leader :integer          default(0), not null
#

class GroupUsersMapping < ActiveRecord::Base
	
end
