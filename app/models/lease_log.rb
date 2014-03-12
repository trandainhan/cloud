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
end
