# frozen_string_literal: true

require_relative '../../../services/game/conspiracy_buyer'
require_relative '../../../models/conspiracy'
require_relative '../../../screens/conspiracy_description_screen'

RSpec.describe Game::ConspiracyBuyer do
  subject(:service) { described_class }

  let(:window) { double('Window') }
  let(:active_conspiracies) { [double('Conspiracy', id: 0)] }
  let(:donations_amount) { donations }
  let(:game_screen) do
    double(
      'GameScreen',
      active_conspiracies: active_conspiracies,
      donations_amount: donations_amount,
      window: window,
      fade_alpha_warning: nil,
      warning_message: nil
    )
  end

  let(:conspiracy_data) { { cost: 100, name: 'Flat Earth', id: 1 } }
  let(:new_conspiracy) { instance_double(Conspiracy) }

  before do
    stub_const('CONSPIRACIES', [conspiracy_data])

    allow(Conspiracy).to receive(:new).and_return(new_conspiracy)
    allow(ConspiracyDescriptionScreen).to receive(:new).and_return(:screen)
    allow(window).to receive(:current_screen=)
    allow(game_screen).to receive(:fade_alpha_warning=)
    allow(game_screen).to receive(:warning_message=)
  end

  describe '.call' do
    context 'when there are enough donations' do
      let(:donations) { 200 }

      it 'adds a new conspiracy' do
        expect do
          service.call(game_screen)
        end.to change { active_conspiracies.size }.by(1)
      end

      it 'pushes a new Conspiracy instance' do
        service.call(game_screen)

        expect(active_conspiracies.last).to eq(new_conspiracy)
      end

      it 'changes the screen' do
        expect(window).to receive(:current_screen=).with(:screen)

        service.call(game_screen)
      end
    end

    context 'when there are not enough donations' do
      let(:donations) { 50 }

      it 'does not add a conspiracy' do
        expect do
          service.call(game_screen)
        end.not_to(change { active_conspiracies.size })
      end

      it 'sets warning message and fade' do
        expect(game_screen).to receive(:fade_alpha_warning=)
        expect(game_screen).to receive(:warning_message=)
          .with('Not enough donations to buy next conspiracy!')

        service.call(game_screen)
      end

      it 'does not change screen' do
        expect(window).not_to receive(:current_screen=)

        service.call(game_screen)
      end
    end
  end
end
