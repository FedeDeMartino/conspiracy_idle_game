# frozen_string_literal: true

require_relative '../../models/conspiracy'

RSpec.describe Conspiracy do
  let(:conspiracy) { Conspiracy.new(id: 1, name: 'Flat Earth', cost: 3) }

  it 'initializes with a name' do
    expect(conspiracy.name).to eq('Flat Earth')
  end

  it 'initializes an id' do
    expect(conspiracy.id).to eq(1)
  end

  it 'initializes a cost' do
    expect(conspiracy.cost).to eq(3)
  end
end
