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

  context 'Test move' do
    it 'should move one step to the right' do
      probe = build(:probe)
      probe.move

      expect(probe.x_position).to eq(1)
    end

    context 'Turn left and move two times' do
      it 'should move two steps up' do
        probe = build(:probe)
        probe.turn_left

        probe.move
        probe.move

        expect(probe.y_position).to eq(2)
      end
    end

    context 'Move more than 4 times' do
      it 'should return false indicating an error' do
        probe = build(:probe)
        probe.move
        probe.move
        probe.move
        probe.move
        last_move = probe.move

        expect(last_move).to eq(false)
      end
    end

    context 'Turn right and move' do
      it 'should return false indicating an error' do
        probe = build(:probe)
        probe.turn_right

        last_move = probe.move
        expect(last_move).to eq(false)
      end
    end
  end

  context 'Test reset' do
    it 'should back the probe values to the default' do
      probe = build(:probe)
      probe.move

      probe.turn_left
      probe.move

      probe.reset
      expect(probe.x_position).to eq(0)
      expect(probe.y_position).to eq(0)
      expect(probe.current_direction).to eq('D')
    end
  end
end
