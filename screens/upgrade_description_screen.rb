# frozen_string_literal: true

require_relative 'base_screen'

class UpgradeDescriptionScreen < BaseScreen
  def initialize(window, upgrade, game_state)
    super(window)
    @upgrade = upgrade
    @font = Gosu::Font.new(15, retro: true)
    @game_state = game_state
  end

  def draw
    @font.draw_text(@upgrade[:name], 100, 10, 1, 1.0, 1.0, Gosu::Color::WHITE)
    @font.draw_text(@upgrade[:description], 100, 40, 1, 1.0, 1.0, Gosu::Color::WHITE)
  end

  def update; end

  def button_down(id)
    case id
    when Gosu::MS_LEFT
      handle_left_click
    end
  end

  private

  def handle_left_click
    @window.current_screen = @game_state
  end
end
