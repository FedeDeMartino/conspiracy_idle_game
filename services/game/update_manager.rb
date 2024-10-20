# frozen_string_literal: true

require 'gosu'

module Game
  # This class is responsible for updating events on the screen
  class UpdateManager
    UPDATE_INTERVAL = 1000
    FADE_DECREMENT = 35
    FADE_NEW_FOLLOWER_DECREMENT = 5
    FADE_WARNING_DECREMENT = 10

    class << self
      def update_game_state(game_screen, current_time)
        update_follower_fade(game_screen)
        update_warning_fade(game_screen)
        update_donations(game_screen)

        return unless time_to_update?(game_screen, current_time)

        update_auto_generated_followers(game_screen)
        game_screen.last_update_time = current_time
      end

      private

      def update_follower_fade(game_screen)
        return if game_screen.latest_follower.empty?

        game_screen.fade_alpha_new_follower = update_fade_alpha(game_screen.fade_alpha_new_follower,
                                                                FADE_NEW_FOLLOWER_DECREMENT)
      end

      def update_warning_fade(game_screen)
        return if game_screen.warning_message.empty?

        game_screen.fade_alpha_warning = update_fade_alpha(game_screen.fade_alpha_warning, FADE_WARNING_DECREMENT)
      end

      def update_donations(game_screen)
        game_screen.donations_amount = game_screen.number_of_followers - game_screen.conspiracies_cost
      end

      def time_to_update?(game_screen, current_time)
        game_screen.are_followers_auto_generated && (current_time - game_screen.last_update_time >= UPDATE_INTERVAL)
      end

      def update_auto_generated_followers(game_screen)
        game_screen.fade_alpha_auto_gen = update_fade_alpha(game_screen.fade_alpha_auto_gen, FADE_DECREMENT)
        game_screen.number_of_followers += game_screen.active_conspiracies.length
      end

      def update_fade_alpha(fade_alpha, decrement)
        [fade_alpha - decrement, 0].max
      end
    end
  end
end
