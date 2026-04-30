# frozen_string_literal: true

require_relative '../../models/conspiracy'
require_relative '../base_service'

module GameWindow
  class SetGameState
    extend BaseService

    MAX_FADE = 255
    NEW_FOLLOWER_FADE_START = 250
    def call
      { active_conspiracies:,
        active_upgrades: [],
        auto_gen_followers_text: '',
        last_update_time: Gosu.milliseconds,
        number_of_followers: 0,
        are_followers_auto_generated: false,
        fade_alpha_auto_gen: MAX_FADE,
        fade_alpha_new_follower: NEW_FOLLOWER_FADE_START,
        fade_alpha_warning: NEW_FOLLOWER_FADE_START,
        latest_follower: '',
        click_x: 0,
        click_y: 0,
        donations_amount: 0,
        warning_message: '' }
    end

    private

    def active_conspiracies
      [Conspiracy.new(id: 1, name: 'The Avocado Agenda', cost: 0)]
    end
  end
end
