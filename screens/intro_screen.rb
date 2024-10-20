# frozen_string_literal: true

require 'gosu'
require 'pry'
require_relative '../services/file_reader'
require_relative 'base_screen'
require_relative 'game_screen'

class IntroScreen < BaseScreen
  WIDTH = 800
  SECTION_TEXTS = {
    start: {
      text: './txt_files/introduction.txt',
      next_section: :first_conspiracy
    },
    first_conspiracy: {
      text: './txt_files/first_conspiracy.txt',
      next_section: :game_start
    }
  }.freeze

  def initialize(window)
    super(window)
    @title_image = Gosu::Image.new('./images/title.png')
    @font = Gosu::Font.new(15, retro: true)
    @starting_information_text = 'Press any key to start!'
    @current_section = :start
  end

  def draw
    @title_image.draw(237, 50, 1, 0.25, 0.25)
    text_width = @font.text_width(@starting_information_text)
    x = (WIDTH - text_width) / 2
    @font.draw_markup(@starting_information_text, x, 150, 1, 1.0, 1.0, Gosu::Color::WHITE)
  end

  def update; end

  def button_down(id)
    return if id != Gosu::MS_LEFT

    change_section_text
  end

  def change_section_text
    if SECTION_TEXTS[@current_section]
      section_text = FileReader.read(SECTION_TEXTS[@current_section][:text])
      @starting_information_text = section_text
      @current_section = SECTION_TEXTS[@current_section][:next_section]
    else
      @window.current_screen = GameScreen.new(@window)
    end
  end
end
