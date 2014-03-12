class AddRatioToVmTypes < ActiveRecord::Migration
  def change
  	add_column :vm_types, :ratio, :float
  end
end
