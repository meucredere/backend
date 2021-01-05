module Interactors
  class ExecuteMovements
    include Interactor

    def call
      raise 'movements are missing' if context.movements.blank?
      raise 'probe is missing' if context.probe.blank?

      context.movements.each do |movement|
        case movement
        when 'M'
          result = context.probe.move
          raise 'Um movimento inválido foi detectado, infelizmente a sonda ainda não possui a habilidade de #vvv' unless result
        when 'GE'
          context.probe.turn_left
        when 'GD'
          context.probe.turn_right
        else
          raise 'An invalid moviment was sent'
        end
      end
    end
  end
end
