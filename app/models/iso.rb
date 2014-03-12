# == Schema Information
#
# Table name: isos
#
#  id          :integer          not null, primary key
#  iso_name    :string(255)      not null
#  is_custom   :boolean          default(FALSE), not null
#  is_clonable :boolean          default(TRUE), not null
#  is_single   :boolean          not null
#  is_group    :boolean          default(FALSE), not null
#  ratio       :float
#

class Iso < ActiveRecord::Base
end
