module Api
  module V1
    class ProbesController < ApplicationController
      before_action :set_probe

      def move
        execute_movements(params[:movimentos].map(&:upcase))

        render json: { 
          x: @probe.x_position,
          y: @probe.y_position,
          description: @probe.description
        }, status: 200
      rescue RuntimeError => e
        render json: { erro: e.message }, status: 400
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
        @probe.description = 'A sonda'
        @probe.save!

        previous_movement = ''
        same_previous_time = 1
        movements.each do |movement|
          case movement
          when 'M'
            previous_movement == 'M' ? same_previous_time += 1 : same_previous_time = 1
            @probe.update_description('M', previous_movement, same_previous_time)

            previous_movement = 'M'

            result = @probe.move
            raise 'Um movimento inválido foi detectado, infelizmente a sonda ainda não possui a habilidade de #vvv' unless result
          when 'GE'
            previous_movement == 'GE' ? same_previous_time += 1 : same_previous_time = 1
            @probe.update_description('GE', previous_movement, same_previous_time)

            previous_movement = 'GE'

            @probe.turn_left
          when 'GD'
            previous_movement == 'GD' ? same_previous_time += 1 : same_previous_time = 1
            @probe.update_description('GD', previous_movement, same_previous_time)

            previous_movement = 'GD'

            @probe.turn_right
          else
            raise 'An invalid moviment was sent'
          end
        end
        @probe.format_description

        true
      end
    end
  end
end
