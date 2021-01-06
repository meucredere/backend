require 'rails_helper'

RSpec.describe Probe, type: :model do
  context 'Test turn right' do
    it 'should turn right the probe and return face equal B' do
      probe = build(:probe)
      probe.turn_right

      expect(probe.current_direction).to eq('B')
    end
  end

  context 'Test turn left' do
    it 'should turn left the probe and return face equal C' do
      probe = build(:probe)
      probe.turn_left

      expect(probe.current_direction).to eq('C')
    end
  end
end
