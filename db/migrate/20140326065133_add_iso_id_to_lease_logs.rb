class AddIsoIdToLeaseLogs < ActiveRecord::Migration
  def change
  	add_column :lease_logs, :iso_id, :integer
  end
end
