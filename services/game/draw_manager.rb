# frozen_string_literal: true

require 'gosu'

module Game
  # This class is responsible for drawing text on the screen
  class DrawManager
    FONT = Gosu::Font.new(15, retro: true)
    WHITE = 0xFFFFFF
    RED = 0xFF0000

    class << self
      def draw_game_screen(game_screen)
        draw_header(game_screen)
        draw_body(game_screen)
        draw_footer
      end

      private

      def draw_header(game_screen)
        draw_text("Active consipiracies: #{game_screen.active_conspiracies_names}", 100, 10)
      end

      def draw_body(game_screen)
        draw_text(game_screen.auto_gen_followers_text, 100, 100, game_screen.fade_alpha_auto_gen)
        draw_text("Number of followers: #{game_screen.number_of_followers}", 100, 130)
        draw_text("Total donations: #{game_screen.donations_amount}$", 100, 150)
        draw_warning_message(game_screen.warning_message, game_screen.fade_alpha_warning)
        draw_text(game_screen.latest_follower, game_screen.click_x, game_screen.click_y,
                  game_screen.fade_alpha_new_follower)
      end

      def draw_footer
        draw_text("(B) to buy a new conspiracy with the follower's donations", 100, 520)
        draw_text('!Left mouse click anywhere to gain followers!', 100, 540)
        draw_text('(ESC) To restart game', 100, 560)
      end

      def draw_text(text, coordinate_x, coordinate_y, alpha = 255)
        return if text.nil? || text.empty?

        color = Gosu::Color.argb((alpha << 24) | WHITE)
        FONT.draw_text(text, coordinate_x, coordinate_y, 1, 1.0, 1.0, color)
      end

      def draw_warning_message(warning_message, alpha = 255)
        return if warning_message.nil? || warning_message.empty?

        color = Gosu::Color.argb((alpha << 24) | RED)
        FONT.draw_text(warning_message, 250, 300, 1, 1.0, 1.0, color)
      end
    end
  end
end
