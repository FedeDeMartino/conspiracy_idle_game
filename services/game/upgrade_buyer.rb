# frozen_string_literal: true

require_relative '../../fixtures/upgrades'

module Game
  # This class is responsible for the logic to buy a new upgrade
  class UpgradeBuyer
    NEW_FOLLOWER_FADE_START = 250

    class << self
      def buy_upgrade(game_screen)
        upgrade = next_upgrade(game_screen.active_upgrades)
        return if upgrade.nil? || not_enough_donations?(upgrade, game_screen)

        game_screen.active_upgrades << upgrade
        game_screen.window.current_screen = UpgradeDescriptionScreen.new(game_screen.window, upgrade, game_screen)
      end

      private

      def next_upgrade(active_upgrades)
        last_upgrade = active_upgrades.last
        index = last_upgrade.nil? ? 0 : last_upgrade[:id]
        UPGRADES[index]
      end

      def not_enough_donations?(upgrade, game_screen)
        return false if upgrade[:cost] <= game_screen.donations_amount

        trigger_warning('Not enough donations to buy next upgrade!', game_screen)
        true
      end

      def trigger_warning(message, game_screen)
        game_screen.fade_alpha_warning = NEW_FOLLOWER_FADE_START
        game_screen.warning_message = message
      end
    end
  end
end
