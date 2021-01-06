require 'rails_helper'

RSpec.describe 'Probes', type: :request do
  before do
    Probe.create
  end

  describe 'POST /probes/move' do
    context 'when it has valid movements' do
      it 'should move the probe successfully' do
        post '/api/v1/probes/move', params: { movimentos: ['M'] }
        expect(Probe.last.x_position).to eq(1)
      end
    end

    context 'when it has invalid movements' do
      it 'should return bad request' do
        result = post '/api/v1/probes/move', params: { movimentos: %w[GD M] }
        expect(result).to eq(400)
      end

      it 'should move the probe until the limit' do
        post '/api/v1/probes/move', params: { movimentos: %w[M M M M M] }
        expect(Probe.last.x_position).to eq(4)
      end
    end
  end
end
