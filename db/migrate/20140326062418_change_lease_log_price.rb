class ChangeLeaseLogPrice < ActiveRecord::Migration
  def change
  	rename_column :lease_logs, :price, :price_per_hour
  	add_column :lease_logs, :total_price, :float
  end
end
