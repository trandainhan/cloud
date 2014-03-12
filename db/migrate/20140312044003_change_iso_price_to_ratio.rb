class ChangeIsoPriceToRatio < ActiveRecord::Migration
  def change
  	add_column :isos, :ratio, :float
  	remove_column :isos, :price
  end
end
