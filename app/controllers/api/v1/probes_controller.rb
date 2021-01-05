module Api
  module V1
    class ProbesController < ApplicationController
      before_action :set_probe

      def move
        execute_movements(params[:movimentos].map(&:upcase))

        render json: { x: @probe.x_position, y: @probe.y_position }, status: 200
      rescue RuntimeError => e
        render json: { erro: e.message }, status: 404
      end

      def reset
        @probe.reset

        render json: {
          x: @probe.x_position,
          y: @probe.y_position,
          face: @probe.current_direction
        }, status: 200
      end

      def current_position
        render json: {
          x: @probe.x_position,
          y: @probe.y_position,
          face: @probe.current_direction
        }, status: 200
      end

      private

      def set_probe
        @probe = Probe.last
      end

      def execute_movements(movements)
        movements.each do |movement|
          case movement
          when 'M'
            result = @probe.move
            raise 'Um movimento inválido foi detectado, infelizmente a sonda ainda não possui a habilidade de #vvv' unless result
          when 'GE'
            @probe.turn_left
          when 'GD'
            @probe.turn_right
          else
            raise 'An invalid moviment was sent'
          end
        end

        true
      end
    end
  end
end
