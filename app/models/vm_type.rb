# == Schema Information
#
# Table name: vm_types
#
#  id    :integer          not null, primary key
#  name  :string(255)      not null
#  cpus  :integer          not null
#  ram   :integer          not null
#  price :float            default(1.0), not null
#  ratio :float
#

class VmType < ActiveRecord::Base

end
