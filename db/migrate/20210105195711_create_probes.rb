class CreateProbes < ActiveRecord::Migration[5.2]
  def change
    create_table :probes do |t|
      t.integer :x_position, default: 0
      t.integer :y_position, default: 0
      t.integer :face, default: 0

      t.timestamps
    end
  end
end
