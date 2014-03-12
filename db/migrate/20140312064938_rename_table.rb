class RenameTable < ActiveRecord::Migration
  def change
  	rename_table :group_users_mapping, :group_users_mappings
  	rename_table :group_vms_mapping, :group_vms_mappings
  	rename_table :lease_log, :lease_logs
  end
end
