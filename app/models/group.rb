# == Schema Information
#
# Table name: groups
#
#  user_id    :integer          not null
#  group_id   :integer          not null, primary key
#  group_name :string(255)      not null
#  numvms     :integer          not null
#  type_id    :integer          default(1), not null
#  iso_id     :integer          default(1), not null
#  state      :boolean          default(FALSE), not null
#

class Group < ActiveRecord::Base
end
