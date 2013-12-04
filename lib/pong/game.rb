module Pong
  class Game < Hasu::Window

    WIDTH  = 768
    HEIGHT = 776

    def initialize
      super(WIDTH, HEIGHT, false)
    end

    def reset
      @ball  = Ball.new
      @court = Court.new

      @left_score = 0
      @right_score = 0

      @font = Gosu::Font.new(self, "Arial", 90)

      @left_paddle = Paddle.new(:left, true)
      @right_paddle = Paddle.new(:right)
    end

    def draw
      @ball.draw(self)
      @court.draw(self)
      @font.draw(@left_score,  (WIDTH/2)-200, 0, 0)
      @font.draw(@right_score, (WIDTH/2)+200, 0, 0)

      @left_paddle.draw(self)
      @right_paddle.draw(self)
    end

    def update
      @ball.move!

      @left_paddle.ai? ? @left_paddle.ai_move!(@ball) :
                         @left_paddle.handle_input!(&method(:button_down?))

      @right_paddle.handle_input!(&method(:button_down?))

      @ball.handle_collisions!(@left_paddle, @right_paddle)
      @ball, @left_score, @right_score = @ball.handle_scoring!(@left_score, @right_score)
    end

    def button_down(button)
      case button
      when Gosu::KbEscape
        close
      end
    end
  end

end
