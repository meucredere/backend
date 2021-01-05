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
      self.y_position += 1
    when 'B'
      self.x_position -= 1
    when 'E'
      self.y_position -= 1
    when 'C'
      self.x_position += 1
    end

    return false if (x_position.negative? || x_position > 4) || (y_position.negative? || y_position > 4)

    save!
  end
end
