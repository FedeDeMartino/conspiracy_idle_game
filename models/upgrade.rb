# frozen_string_literal: true

class Upgrade
  attr_reader :name, :cost, :id

  MODIFIER_TYPES = [
    CLICKS_PER_SECOND    = :clicks_per_second,
    FOLLOWERS_PER_SECOND = :followers_per_second
  ].freeze

  def initialize(id:, name:, cost:)
    @id = id
    @name = name
    @cost = cost
  end
end
