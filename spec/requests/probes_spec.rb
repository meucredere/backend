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

      it 'should return the new position' do
        post '/api/v1/probes/move', params: { movimentos: ['M'] }
        result = JSON.parse(response.body)
        expect(result&.dig('x')).to eq(1)
        expect(result&.dig('y')).to eq(0)
        expect(result&.dig('description')).to eq('A sonda moveu 1 casa(s) no eixo x')
      end
    end

    context 'when it has invalid movements' do
      it 'should return bad request' do
        post '/api/v1/probes/move', params: { movimentos: %w[GD M] }
        expect(response.code).to eq('400')
      end

      it 'should return an error' do
        post '/api/v1/probes/move', params: { movimentos: %w[GD M] }
        result = JSON.parse(response.body)
        expect(result&.dig('erro')).to eq('Um movimento inválido foi detectado, infelizmente a sonda ainda não possui a habilidade de #vvv')
      end

      it 'should move the probe until the limit' do
        post '/api/v1/probes/move', params: { movimentos: %w[M M M M M] }
        expect(Probe.last.x_position).to eq(4)
      end
    end
  end
end
