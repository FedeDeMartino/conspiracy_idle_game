# frozen_string_literal: true

require 'gosu'
require_relative 'intro_screen'

class ConspiracyScreen < Gosu::Window
  WIDTH = 800
  HEIGHT = 600
  TITLE = 'Conspiracy Idle Game'

  attr_accessor :current_screen

  def initialize
    super(WIDTH, HEIGHT)
    self.caption = TITLE
    @width = WIDTH
    @current_screen = IntroScreen.new(self)
  end

  def update
    @current_screen.update
  end

  def draw
    @current_screen.draw
  end

  def button_down(id)
    @current_screen.button_down(id)
  end
end
