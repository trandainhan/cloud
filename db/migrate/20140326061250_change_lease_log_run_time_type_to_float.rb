class ChangeLeaseLogRunTimeTypeToFloat < ActiveRecord::Migration
  def change
  	change_column :lease_logs, :run_time, :float
  end
end
