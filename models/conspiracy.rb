# frozen_string_literal: true

class Conspiracy
  attr_reader :name, :cost, :id

  def initialize(id:, name:, cost:)
    @id = id
    @name = name
    @cost = cost
  end
end
