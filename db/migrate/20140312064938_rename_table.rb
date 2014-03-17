class RenameTable < ActiveRecord::Migration
  def change
  	rename_table :lease_log, :lease_logs
  end
end
