class Probe < ApplicationRecord
  def current_direction
    directions = %w[D B E C]

    directions[face]
  end

  def turn_right
    self.face += 1
    self.face = 0 if face == 4

    save!
  end

  def turn_left
    self.face -= 1
    self.face = -1 if face == -5

    save!
  end

  def move
    case current_direction
    when 'D'
      self.x_position += 1
    when 'B'
      self.y_position -= 1
    when 'E'
      self.x_position -= 1
    when 'C'
      self.y_position += 1
    end

    return false if (x_position.negative? || x_position > 4) || (y_position.negative? || y_position > 4)

    save!
  end

  def reset
    self.x_position = 0
    self.y_position = 0
    self.face = 0

    save!
  end

  def update_description(movement, previous_movement, same_previous_time)
    current_description = description.split(', ')

    case movement
    when 'M'
      if previous_movement == 'M'
        if current_direction == 'D' || current_direction == 'E'
          current_description[-1] = "moveu #{same_previous_time} casa(s) no eixo x"
        else
          current_description[-1] = "moveu #{same_previous_time} casa(s) no eixo y"
        end
      else
        if current_direction == 'D' || current_direction == 'E'
          current_description << "moveu #{same_previous_time} casa(s) no eixo x"
        else
          current_description << "moveu #{same_previous_time} casa(s) no eixo y"
        end
      end
    when 'GE'
      if previous_movement == 'GE'
        current_description[-1] = "girou para a esquerda #{same_previous_time} veze(s)"
      else
        current_description << "girou para a esquerda #{same_previous_time} veze(s)"
      end
    when 'GD'
      if previous_movement == 'GD'
        current_description[-1] = "girou para a direita #{same_previous_time} veze(s)"
      else
        current_description << "girou para a direita #{same_previous_time} veze(s)"
      end
    end

    self.description = current_description.join(', ')
    save!
  end

  def format_description
    self.description = description.sub(', ', ' ')
    self.description = description.reverse.sub(' ,', ' e ',).reverse

    save!
  end
end
