class Probe < ApplicationRecord
  def current_direction
    directions = %w[R D L U]

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
    when 'R'
      self.y_position += 1
    when 'D'
      self.x_position -= 1
    when 'L'
      self.y_position -= 1
    when 'U'
      self.x_position += 1
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
end
