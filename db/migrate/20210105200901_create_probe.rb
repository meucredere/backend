class CreateProbe < ActiveRecord::Migration[5.2]
  def up
    Probe.create!
  end

  def down
    Probe.last&.destroy
  end
end
