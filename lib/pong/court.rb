require 'gosu'

module Pong
  class Court
    TOP    = 100
    WIDTH  = 768
    HEIGHT = 576

    def draw(window)
      draw_midfield_line(window)
      draw_edges(window)
    end

    def draw_midfield_line(window)
      segs, top = [], TOP
      while top < HEIGHT+100; segs << [top, top+9]; top = top+10; end
      segs.each_with_index.map do |(start, stop), i|
        color = i%2 == 0 ? Gosu::Color::WHITE : Gosu::Color::BLACK
        (((WIDTH/2)-2)..((WIDTH/2)+2)).each do |x|
          window.draw_line(x, start, color, x, stop, color)
        end
      end
    end

    def draw_edges(window)
      color = Gosu::Color::WHITE
      window.draw_line(0, TOP, color, WIDTH, TOP, color)
      window.draw_line(0, HEIGHT+TOP, color, WIDTH, HEIGHT+TOP, color)
    end
  end
end
