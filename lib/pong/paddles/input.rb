module Pong
  module Paddles
    module Input
      extend Forwardable

      def_delegator :@game, :button_down?

      def handle_input(&meth)
        return up!   if meth.call(up_button)
        return down! if meth.call(down_button)
      end

    private

      def up_button
        send("#{side}_up_button")
      end

      def down_button
        send("#{side}_down_button")
      end

      def left_up_button
        Gosu::KbW
      end

      def left_down_button
        Gosu::KbS
      end
      
      def right_up_button
        Gosu::KbUp
      end

      def right_down_button
        Gosu::KbDown
      end
    end
  end
end

