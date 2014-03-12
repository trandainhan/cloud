# == Schema Information
#
# Table name: users
#
#  id        :integer          not null, primary key
#  username  :string(45)       not null
#  activated :boolean          default(FALSE), not null
#

class User < ActiveRecord::Base
  
end
