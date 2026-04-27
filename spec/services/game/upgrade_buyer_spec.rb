# frozen_string_literal: true

require_relative '../../../services/game/upgrade_buyer'
require_relative '../../../models/upgrade'
require_relative '../../../screens/upgrade_description_screen'

RSpec.describe Game::UpgradeBuyer do
  let(:game_screen) do
    double('GameScreen', active_upgrades:, donations_amount:, window:)
  end
  let(:active_upgrades) { [] }
  let(:upgrade) { { cost: 100, name: 'Flat Earth', id: 1, description: 'Earth flat' } }
  let(:window) { double('Window', current_screen: nil) }

  before do
    stub_const('UPGRADES', [upgrade])
    allow(UpgradeDescriptionScreen).to receive(:new)
    allow(Game::UpgradeBuyer).to receive(:trigger_warning)
  end

  describe '.buy_upgrade' do
    context 'when there are enough donations' do
      let(:donations_amount) { 200 }

      it 'adds a new upgrade to the active_upgrades list' do
        expect(game_screen.window).to receive(:current_screen=)
        expect do
          Game::UpgradeBuyer.buy_upgrade(game_screen)
        end.to change { game_screen.active_upgrades.size }.by(1)
      end
    end

    context 'when there are not enough donations' do
      let(:donations_amount) { 50 }

      it 'does not add a new upgrade to the active_upgrades list' do
        expect do
          Game::UpgradeBuyer.buy_upgrade(game_screen)
        end.not_to(change { game_screen.active_upgrades.size })
      end

      it 'triggers a warning message' do
        expect(Game::UpgradeBuyer).to receive(:trigger_warning).with('Not enough donations to buy next upgrade!', game_screen)
        Game::UpgradeBuyer.buy_upgrade(game_screen)
      end
    end
  end
end
