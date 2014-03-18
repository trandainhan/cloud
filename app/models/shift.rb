# == Schema Information
#
# Table name: shifts
#
#  id          :integer          not null, primary key
#  shift_type  :string(255)
#  description :string(255)
#  from        :string(255)
#  to          :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Shift < ActiveRecord::Base
	VALID_TIME_REGEX= /(?:0?[0-9]|1[0-9]|2[0-3]):[0-5][0-9]/
	validates :from, :to,
	presence: true,
	format: {
		with: VALID_TIME_REGEX
	}

	def self.red_shift_start
		Shift.where('shift_type = ?', 'red shift').last.from
	end

	def self.red_shift_end
		Shift.where('shift_type = ?', 'red shift').last.to
	end

	def self.blue_shift_start
		Shift.where('shift_type = ?', 'blue shift').last.from
	end

	def self.blue_shift_end
		Shift.where('shift_type = ?', 'blue shift').last.to
	end
end
