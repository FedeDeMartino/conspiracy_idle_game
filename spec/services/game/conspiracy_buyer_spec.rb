# frozen_string_literal: true

require_relative '../../../services/game/conspiracy_buyer'
require_relative '../../../models/conspiracy'
require_relative '../../../screens/conspiracy_description_screen'

RSpec.describe Game::ConspiracyBuyer do
  let(:game_screen) do
    double('GameScreen', active_conspiracies:, donations_amount:, window:)
  end
  let(:active_conspiracies) { [double('Conspiracy', id: 0)] }
  let(:conspiracy) { { cost: 100, name: 'Flat Earth', id: 1 } }
  let(:window) { double('Window', current_screen: nil) }

  before do
    stub_const('CONSPIRACIES', [conspiracy])
    allow(ConspiracyDescriptionScreen).to receive(:new)
    allow(Game::ConspiracyBuyer).to receive(:trigger_warning)
  end

  describe '.buy_conspiracy' do
    context 'when there are enough donations' do
      let(:donations_amount) { 200 }

      it 'adds a new conspiracy to the active_conspiracies list' do
        expect(game_screen.window).to receive(:current_screen=)
        expect do
          Game::ConspiracyBuyer.buy_conspiracy(game_screen)
        end.to change { game_screen.active_conspiracies.size }.by(1)
      end
    end

    context 'when there are not enough donations' do
      let(:donations_amount) { 50 }

      it 'does not add a new conspiracy to the active_conspiracies list' do
        expect do
          Game::ConspiracyBuyer.buy_conspiracy(game_screen)
        end.not_to(change { game_screen.active_conspiracies.size })
      end

      it 'triggers a warning message' do
        expect(Game::ConspiracyBuyer).to receive(:trigger_warning).with('Not enough donations to buy next conspiracy!',
                                                                        game_screen)
        Game::ConspiracyBuyer.buy_conspiracy(game_screen)
      end
    end
  end
end
