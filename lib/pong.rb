require "pong/version"

Hasu.load "pong/game.rb"
Hasu.load "pong/ball.rb"
Hasu.load "pong/court.rb"
Hasu.load "pong/paddle.rb"

module Pong
  extend self

  def start
    Game.run
  end
end
