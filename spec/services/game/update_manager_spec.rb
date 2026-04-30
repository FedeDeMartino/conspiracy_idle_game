# frozen_string_literal: true

require_relative '../../../services/game/update_manager'

RSpec.describe Game::UpdateManager do
  let(:current_time) { 2000 }

  let(:game_screen) do
    double(
      'GameScreen',
      latest_follower: 'John Doe',
      fade_alpha_new_follower: 100,
      warning_message: 'Warning!',
      fade_alpha_warning: 150,
      donations_amount: 0,
      number_of_followers: 50,
      conspiracies_cost: 20,
      are_followers_auto_generated: true,
      fade_alpha_auto_gen: 100,
      active_conspiracies: [double('Conspiracy')],
      last_update_time: 0
    )
  end

  subject(:service) { described_class.new(game_screen, current_time) }

  before do
    allow(game_screen).to receive(:fade_alpha_new_follower=)
    allow(game_screen).to receive(:fade_alpha_warning=)
    allow(game_screen).to receive(:fade_alpha_auto_gen=)
    allow(game_screen).to receive(:number_of_followers=)
    allow(game_screen).to receive(:number_of_followers).and_return(50)
    allow(game_screen).to receive(:donations_amount=)
    allow(game_screen).to receive(:last_update_time=)
  end

  describe '#call' do
    before do
      allow(service).to receive(:time_to_update?).and_return(true)
    end

    it 'updates the follower fade if there is a latest follower' do
      expect(game_screen).to receive(:fade_alpha_new_follower=).with(95)

      service.call
    end

    it 'updates the warning fade if there is a warning message' do
      expect(game_screen).to receive(:fade_alpha_warning=).with(140)

      service.call
    end

    it 'updates donations' do
      expect(game_screen).to receive(:donations_amount=).with(30)

      service.call
    end

    context 'when it is time to update auto-generated followers' do
      it 'updates followers and fade' do
        expect(game_screen).to receive(:fade_alpha_auto_gen=).with(65)
        expect(game_screen).to receive(:number_of_followers=).with(51)

        service.call
      end

      it 'updates last_update_time' do
        expect(game_screen).to receive(:last_update_time=).with(current_time)

        service.call
      end
    end

    context 'when it is not time to update auto-generated followers' do
      before do
        allow(service).to receive(:time_to_update?).and_return(false)
      end

      it 'does not update followers or fade' do
        expect(game_screen).not_to receive(:fade_alpha_auto_gen=)
        expect(game_screen).not_to receive(:number_of_followers=)

        service.call
      end
    end
  end

  describe '#update_fade_alpha' do
    it 'decreases fade_alpha but not below zero' do
      expect(service.send(:update_fade_alpha, 10, 5)).to eq(5)
      expect(service.send(:update_fade_alpha, 5, 10)).to eq(0)
    end
  end
end
