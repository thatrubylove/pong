require 'pong/balls/intersection'

module Pong
  class Ball
    include Pong::Balls::Intersection

    SIZE = 16

    attr_reader :x, :y, :angle, :speed
    def initialize
      @x = Game::WIDTH/2
      @y = Game::HEIGHT/2

      @angle = rand(120) + 30
      @angle *= -1  if rand > 0.5
      @speed = 6
    end

    def dx; Gosu.offset_x(angle, speed); end
    def dy; Gosu.offset_y(angle, speed); end

    def move!
      @x += dx
      @y += dy

      if @y < 0
        @y = 0
        bounce_off_edge!
      end

      if @y > Game::HEIGHT
        @y = Game::HEIGHT
        bounce_off_edge!
      end
    end

    def bounce_off_edge!
      @angle = Gosu.angle(0, 0, dx, -dy)
    end

    def x1; @x - SIZE/2; end
    def x2; @x + SIZE/2; end
    def y1; @y - SIZE/2; end
    def y2; @y + SIZE/2; end

    def draw(window)
      color = Gosu::Color::RED

      window.draw_quad(
        x1, y1, color,
        x1, y2, color,
        x2, y2, color,
        x2, y1, color,
      )
    end

    def off_left?
      x1 < 0
    end

    def off_right?
      x2 > Game::WIDTH
    end
    
    def bounce_off(paddle)
      case paddle.side
      when :left
      when :right
        @x = paddle.x2 + SIZE/2
        @x = paddle.x1 - SIZE/2
      end

      ratio = (y - paddle.y) / Paddle::HEIGHT
      @angle = ratio * 120 + 90
      @angle *= -1  if paddle.side == :right

      @speed *= 1.1
    end


    def handle_collisions!(*paddles)
      paddles.each do |paddle|
        bounce_off(paddle) if intersect?(paddle)
      end
    end

    def handle_scoring!(left_score, right_score)
      return [self, left_score, right_score] unless off_left? || off_right?

      right_score += 1 if off_left?
      left_score  += 1 if off_right?
      [Ball.new, left_score, right_score]
    end
  end
end
