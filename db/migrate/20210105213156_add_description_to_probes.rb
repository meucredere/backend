class AddDescriptionToProbes < ActiveRecord::Migration[5.2]
  def change
    add_column :probes, :description, :string
  end
end
