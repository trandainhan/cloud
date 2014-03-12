class CreateShifts < ActiveRecord::Migration
  def change
    create_table :shifts do |t|
			t.string :shift_type
      t.string :description
      t.string :from
      t.string :to
      t.timestamps
    end
  end
end
