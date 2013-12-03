module Pong
  module Balls
    module Intersection

      def handle_intersects(paddle)
        return bounce_off_paddle!(paddle) if intersect?(paddle)
      end
    
      def bounce_off_paddle!(paddle)
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

      def intersect?(paddle)
        x1 < paddle.x2 &&
          x2 > paddle.x1 &&
          y1 < paddle.y2 &&
          y2 > paddle.y1
      end

    end
  end
end
