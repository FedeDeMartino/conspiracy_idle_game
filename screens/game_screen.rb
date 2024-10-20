# frozen_string_literal: true

require_relative 'base_screen'
require_relative 'intro_screen'
require_relative 'conspiracy_description_screen'
require_relative '../models/conspiracy'
require_relative '../fixtures/follower_names'
require_relative '../services/game/draw_manager'
require_relative '../services/game/update_manager'
require_relative '../services/game/conspiracy_buyer'

# GameScreen is responsible for handling the main gameplay screen
class GameScreen < BaseScreen
  MINIMUM_FOLLOWERS = 10
  MAX_FADE = 255
  NEW_FOLLOWER_FADE_START = 250

  attr_accessor :fade_alpha_auto_gen, :fade_alpha_new_follower, :latest_follower,
                :last_update_time, :number_of_followers, :donations_amount, :fade_alpha_warning,
                :warning_message, :window

  attr_reader :active_conspiracies, :auto_gen_followers_text, :are_followers_auto_generated,
              :click_x, :click_y

  def initialize(window)
    super(window)
    initialize_game_state
  end

  def draw
    ::Game::DrawManager.draw_game_screen(self)
  end

  def update
    current_time = Gosu.milliseconds
    ::Game::UpdateManager.update_game_state(self, current_time)
  end

  def button_down(id)
    case id
    when Gosu::KB_ESCAPE then switch_to_intro_screen
    when Gosu::MS_LEFT then handle_left_click
    when Gosu::KB_B then handle_buy_conspiracy
    end
  end

  def active_conspiracies_names
    format_conspiracy_names(@active_conspiracies.map(&:name))
  end

  def conspiracies_cost
    @active_conspiracies.sum(&:cost)
  end

  private

  def initialize_game_state
    @active_conspiracies = [Conspiracy.new(id: 1, name: 'The Avocado Agenda', cost: 0)]
    @auto_gen_followers_text = ''
    @last_update_time = Gosu.milliseconds
    @number_of_followers = 0
    @are_followers_auto_generated = false
    @fade_alpha_auto_gen = MAX_FADE
    @fade_alpha_new_follower = NEW_FOLLOWER_FADE_START
    @fade_alpha_warning = NEW_FOLLOWER_FADE_START
    @latest_follower = ''
    @click_x = 0
    @click_y = 0
    @donations_amount = 0
    @warning_message = ''
  end

  def switch_to_intro_screen
    @window.current_screen = IntroScreen.new(@window)
  end

  def update_fade_alpha(fade_alpha, decrement)
    [fade_alpha - decrement, 0].max
  end

  def handle_left_click
    @fade_alpha_new_follower = NEW_FOLLOWER_FADE_START
    @latest_follower = "New follower: #{NAMES.sample}"
    update_click_coordinates
    @number_of_followers += 1
    start_auto_generation if @number_of_followers == MINIMUM_FOLLOWERS
  end

  def update_click_coordinates
    @click_x = @window.mouse_x
    @click_y = @window.mouse_y
  end

  def start_auto_generation
    @are_followers_auto_generated = true
    message = "You have reached #{MINIMUM_FOLLOWERS} followers!\nYour followers can start recruiting other followers!"
    @auto_gen_followers_text = message
  end

  def handle_buy_conspiracy
    ::Game::ConspiracyBuyer.buy_conspiracy(self)
  end

  def format_conspiracy_names(names)
    names.each_slice(3).map { |group| group.join(', ') }.join("\n")
  end
end
