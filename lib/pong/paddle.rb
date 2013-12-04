require 'pong/paddles/input'

module Pong
  class Paddle
    TOP = 100
    WIDTH = 16
    HEIGHT = 96
    SPEED = 6

    include Pong::Paddles::Input

    attr_reader :side, :y, :ai

    alias ai? ai

    def initialize(side, ai=false)
      @ai = ai
      @side = side
      @y = Court::HEIGHT/2
    end

    def ai_move!(ball)
      if (y - ball.y).abs > SPEED
        if y > ball.y
          up!
        else
          down!
        end
      end
    end

    def x1
      case side
      when :left
        0
      when :right
        Court::WIDTH - WIDTH
      end
    end

    def x2
      x1 + WIDTH
    end

    def y1
      y - HEIGHT/2
    end

    def y2
      y1 + HEIGHT
    end

    def draw(window)
      color = Gosu::Color::WHITE

      window.draw_quad(
        x1, y1, color,
        x1, y2, color,
        x2, y2, color,
        x2, y1, color,
      )
    end

    def up!
      @y -= SPEED

      if y1 < TOP
        @y = HEIGHT+TOP/2
      end
    end

    def down!
      @y += SPEED

      if y2 > Court::HEIGHT+TOP
       @y = Court::HEIGHT+TOP - HEIGHT/2
      end
    end
  end
end
