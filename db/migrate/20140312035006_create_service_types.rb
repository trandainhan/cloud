class CreateServiceTypes < ActiveRecord::Migration
  def change
    create_table :service_types do |t|
    	t.string :name
			t.float :unit_value
			t.string :description
      t.timestamps
    end
  end
end
