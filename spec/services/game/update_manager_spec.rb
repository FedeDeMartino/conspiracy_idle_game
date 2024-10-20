# frozen_string_literal: true

require_relative '../../../services/game/update_manager'

RSpec.describe Game::UpdateManager do
  let(:game_screen) do
    double('GameScreen',
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
           last_update_time: 0)
  end
  let(:current_time) { 2000 }

  before do
    allow(game_screen).to receive(:fade_alpha_new_follower=)
    allow(game_screen).to receive(:fade_alpha_warning=)
    allow(game_screen).to receive(:fade_alpha_auto_gen=)
    allow(game_screen).to receive(:number_of_followers=)
    allow(game_screen).to receive(:donations_amount=)
    allow(game_screen).to receive(:last_update_time=)
  end

  describe '.update_game_state' do
    before do
      allow(Game::UpdateManager).to receive(:time_to_update?).and_return(true)
    end

    it 'updates the follower fade if there is a latest follower' do
      expect(game_screen).to receive(:fade_alpha_new_follower=).with(95)
      Game::UpdateManager.update_game_state(game_screen, current_time)
    end

    it 'updates the warning fade if there is a warning message' do
      expect(game_screen).to receive(:fade_alpha_warning=).with(140)
      Game::UpdateManager.update_game_state(game_screen, current_time)
    end

    context 'when it is time to update auto-generated followers' do
      it 'updates the number of followers based on active conspiracies' do
        expect(game_screen).to receive(:fade_alpha_auto_gen=).with(65)
        expect(game_screen).to receive(:number_of_followers=).with(51)
        Game::UpdateManager.update_game_state(game_screen, current_time)
      end
    end

    context 'when it is not time to update auto-generated followers' do
      before do
        allow(Game::UpdateManager).to receive(:time_to_update?).and_return(false)
      end

      it 'does not update the number of followers' do
        expect(game_screen).not_to receive(:fade_alpha_auto_gen=)
        expect(game_screen).not_to receive(:number_of_followers=)
        Game::UpdateManager.update_game_state(game_screen, current_time)
      end
    end
  end

  describe '.update_fade_alpha' do
    it 'decreases fade_alpha by the decrement but not below zero' do
      result = Game::UpdateManager.send(:update_fade_alpha, 10, 5)
      expect(result).to eq(5)

      result = Game::UpdateManager.send(:update_fade_alpha, 5, 10)
      expect(result).to eq(0)
    end
  end
end
