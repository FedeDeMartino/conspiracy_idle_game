# frozen_string_literal: true

require 'gosu'
require_relative 'services/file_reader'

class ConspiracyWindow < Gosu::Window
  WIDTH = 800
  HEIGHT = 600
  SECTION_TEXTS = {
    start: {
      text: './txt_files/introduction.txt',
      next_section: :first_conspiracy
    },
    first_conspiracy: {
      text: './txt_files/first_conspiracy.txt',
      next_section: :second_conspiracy
    }
  }.freeze

  def initialize
    super(WIDTH, HEIGHT)
    self.caption = 'Conspiracy Idle Game'
    @title_image = Gosu::Image.new('./images/title.png')
    @font_starting_information = Gosu::Font.new(15, retro: true)
    @starting_information_text = 'Press any key to start!'
    @current_section = :start
  end

  def draw
    @title_image.draw(237, 50, 1, 0.25, 0.25)
    text_width = @font_starting_information.text_width(@starting_information_text)
    x = (width - text_width) / 2
    @font_starting_information.draw_markup(@starting_information_text, x, 150, 1, 1.0, 1.0, Gosu::Color::WHITE)
  end

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
      @starting_information_text = ''
    end
  end
end

window = ConspiracyWindow.new
window.show
