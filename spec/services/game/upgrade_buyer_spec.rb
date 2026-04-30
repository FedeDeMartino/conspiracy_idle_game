# frozen_string_literal: true

require_relative '../../../services/game/upgrade_buyer'
require_relative '../../../models/upgrade'
require_relative '../../../screens/upgrade_description_screen'

RSpec.describe Game::UpgradeBuyer do
  subject(:service) { described_class.new(game_screen) }

  let(:active_upgrades) { [] }
  let(:donations_amount) { donations }
  let(:window) { double('Window') }

  let(:game_screen) do
    double(
      'GameScreen',
      active_upgrades: active_upgrades,
      donations_amount: donations_amount,
      window: window,
      fade_alpha_warning: nil,
      warning_message: nil
    )
  end

  let(:upgrade) do
    { cost: 100, name: 'Flat Earth', id: 0, description: 'Earth flat' }
  end

  before do
    stub_const('UPGRADES', [upgrade])

    allow(window).to receive(:current_screen=)
    allow(game_screen).to receive(:fade_alpha_warning=)
    allow(game_screen).to receive(:warning_message=)

    allow(UpgradeDescriptionScreen).to receive(:new).and_return(:screen)
  end

  describe '#call' do
    context 'when there are enough donations' do
      let(:donations) { 200 }

      it 'adds a new upgrade to the list' do
        expect do
          service.call
        end.to change { active_upgrades.size }.by(1)
      end

      it 'pushes the correct upgrade' do
        service.call

        expect(active_upgrades.last).to eq(upgrade)
      end

      it 'changes the screen' do
        expect(window).to receive(:current_screen=).with(:screen)

        service.call
      end
    end

    context 'when there are not enough donations' do
      let(:donations) { 50 }

      it 'does not add an upgrade' do
        expect do
          service.call
        end.not_to(change { active_upgrades.size })
      end

      it 'sets warning message and fade' do
        expect(game_screen).to receive(:fade_alpha_warning=).with(250)
        expect(game_screen).to receive(:warning_message=)
          .with('Not enough donations to buy next upgrade!')

        service.call
      end

      it 'does not change screen' do
        expect(window).not_to receive(:current_screen=)

        service.call
      end
    end

    context 'when there are no upgrades yet' do
      let(:donations) { 200 }

      it 'picks the first upgrade' do
        service.call

        expect(active_upgrades.first).to eq(upgrade)
      end
    end
  end
end
