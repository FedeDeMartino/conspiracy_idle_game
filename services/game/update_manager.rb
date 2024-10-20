# frozen_string_literal: true

require 'gosu'

module Game
  # This class is responsible for the updaring events on the screen
  class UpdateManager
    UPDATE_INTERVAL = 1000
    FADE_DECREMENT = 35
    FADE_NEW_FOLLOWER_DECREMENT = 5
    FADE_WARNING_DECREMENT = 10

    class << self
      def update_game_state(game_screen, current_time)
        if game_screen.latest_follower != ''
          game_screen.fade_alpha_new_follower = update_fade_alpha(game_screen.fade_alpha_new_follower,
                                                                  FADE_NEW_FOLLOWER_DECREMENT)
        end
        if game_screen.warning_message != ''
          game_screen.fade_alpha_warning = update_fade_alpha(game_screen.fade_alpha_warning, FADE_WARNING_DECREMENT)
        end
        game_screen.donations_amount = (game_screen.number_of_followers - game_screen.conspiracies_cost)
        is_not_time_to_update = current_time - game_screen.last_update_time >= UPDATE_INTERVAL
        return unless game_screen.are_followers_auto_generated && is_not_time_to_update

        game_screen.fade_alpha_auto_gen = update_fade_alpha(game_screen.fade_alpha_auto_gen, FADE_DECREMENT)
        game_screen.number_of_followers += game_screen.active_conspiracies.length
        game_screen.last_update_time = current_time
      end

      def update_fade_alpha(fade_alpha, decrement)
        return 0 if fade_alpha <= decrement

        fade_alpha - decrement
      end
    end
  end
end
