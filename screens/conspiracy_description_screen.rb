# frozen_string_literal: true

require_relative '../services/file_reader'

class ConspiracyDescriptionScreen < BaseScreen
  def initialize(window, conspiracy, game_state)
    super(window)
    @conspiracy = conspiracy
    @font = Gosu::Font.new(15, retro: true)
    @game_state = game_state
  end

  def draw
    conspiracy_name = @conspiracy.downcase.gsub(' ', '_')
    conspiracy_text = FileReader.read("./txt_files/#{conspiracy_name}.txt")
    @font.draw_markup(conspiracy_text, 100, 10, 1, 1.0, 1.0, Gosu::Color::WHITE)
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
