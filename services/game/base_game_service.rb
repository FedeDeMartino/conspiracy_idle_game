# frozen_string_literal: true

require_relative '../base_service'

module Game
  class BaseGameService
    extend BaseService

    def initialize(game_screen)
      @game_screen = game_screen
    end

    private

    attr_reader :game_screen
  end
end
