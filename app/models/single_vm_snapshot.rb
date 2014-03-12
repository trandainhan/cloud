# == Schema Information
#
# Table name: single_vm_snapshots
#
#  id       :integer          not null, primary key
#  vm_id    :integer          not null
#  image_id :integer          not null
#  iso_id   :integer          not null
#  name     :string(255)      not null
#

class SingleVmSnapshot < ActiveRecord::Base
end
