require 'rails_helper'

RSpec.describe Probe, type: :model do
  context 'Test turn right' do
    it 'should turn right the probe and return face equal B' do
      probe = create(:probe)
      probe.turn_right

      expect(probe.current_direction).to eq('B')
    end
  end
end
