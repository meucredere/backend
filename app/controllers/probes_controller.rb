module Api
  module V1
    class ProbesController < ApplicationController
      include Interactors

      before_action :set_probe

      def move
        result = ExecuteMovements.call(movements: params[:movimentos], probe: @probe)
        if result.success?
          render json: { x: @probe.x_position, y: @probe.y_position }, status: 200
        else
          render json: { erro: result.message }, status: 404
        end
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
    end
  end
end
