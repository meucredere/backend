class CreateProbes < ActiveRecord::Migration[5.2]
  def change
    create_table :probes do |t|
      t.integer :x_position
      t.integer :y_position
      t.integer :face

      t.timestamps
    end
  end
end
