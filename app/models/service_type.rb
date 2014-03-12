# == Schema Information
#
# Table name: service_types
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  unit_value  :float
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class ServiceType < ActiveRecord::Base
end
