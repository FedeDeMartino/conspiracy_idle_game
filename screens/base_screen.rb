# frozen_string_literal: true

require 'gosu'

class BaseScreen
  def initialize(window)
    @window = window
  end

  def draw
    raise 'You must implement this method in a subclass'
  end

  def update
    raise 'You must implement this method in a subclass'
  end
end
