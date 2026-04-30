# frozen_string_literal: true

require_relative '../../fixtures/conspiracies'
require_relative './base_game_service'

module Game
  # This class is responsible for the logic to buy a new conspiracy
  class ConspiracyBuyer < BaseGameService
    extend BaseService
    NEW_FOLLOWER_FADE_START = 250

    def call
      last_conspiracy = game_screen.active_conspiracies.last
      conspiracy = CONSPIRACIES[last_conspiracy.id]
      return if conspiracy.nil? || not_enough_donations?(conspiracy, game_screen)

      game_screen.active_conspiracies << Conspiracy.new(**conspiracy)
      game_screen.window.current_screen = ConspiracyDescriptionScreen.new(game_screen.window, conspiracy[:name],
                                                                          game_screen)
    end

    private

    attr_reader :game_screen

    def not_enough_donations?(conspiracy, game_screen)
      return false if conspiracy[:cost] <= game_screen.donations_amount

      trigger_warning('Not enough donations to buy next conspiracy!', game_screen)
      true
    end

    def trigger_warning(message, game_screen)
      game_screen.fade_alpha_warning = NEW_FOLLOWER_FADE_START
      game_screen.warning_message = message
    end
  end
end
